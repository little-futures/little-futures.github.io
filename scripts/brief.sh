#!/usr/bin/env bash
# Little Futures briefing — post recent notes to Discord.
#
# Usage:
#   scripts/brief.sh               # default: last 7 days
#   scripts/brief.sh 14d           # last 14 days
#   scripts/brief.sh since-last    # since previous run (falls back to 7d)
#   scripts/brief.sh --dry-run     # print payload, don't post
#   scripts/brief.sh 7d --dry-run  # combine

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

SITE_URL="https://little-futures.github.io"
LAST_RUN_FILE=".claude/last-brief.txt"

WINDOW="7d"
DRY_RUN=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    *) WINDOW="$arg" ;;
  esac
done

if [[ -f .env ]]; then
  # Parse KEY=VALUE lines rather than sourcing (so .env is config, not code).
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "${line// }" || "${line#"${line%%[![:space:]]*}"}" == \#* ]] && continue
    if [[ "$line" =~ ^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*)=(.*)$ ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      [[ "$value" =~ ^\"(.*)\"$ ]] && value="${BASH_REMATCH[1]}"
      [[ "$value" =~ ^\'(.*)\'$ ]] && value="${BASH_REMATCH[1]}"
      export "$key=$value"
    fi
  done < .env
fi

if [[ $DRY_RUN -eq 0 && -z "${DISCORD_BRIEFING_WEBHOOK:-}" ]]; then
  echo "Error: DISCORD_BRIEFING_WEBHOOK not set (check .env)" >&2
  exit 1
fi

if [[ "$WINDOW" == "since-last" && -f "$LAST_RUN_FILE" ]]; then
  SINCE="$(cat "$LAST_RUN_FILE")"
elif [[ "$WINDOW" =~ ^([0-9]+)d$ ]]; then
  SINCE="${BASH_REMATCH[1]} days ago"
else
  SINCE="7 days ago"
fi

echo "Collecting notes changed since: $SINCE"

# Collect added/modified .md files in the three curated dirs, deduped, newest status wins.
CHANGED=()
CHANGED_RAW="$(
  git log --since="$SINCE" --name-status --pretty=format: --diff-filter=AM -- \
    content/notes/ content/tom/ content/brian/ \
    | awk 'NF >= 2 && $1 ~ /^[AM]$/ && $2 ~ /\.md$/ {print $1"\t"$2}' \
    | awk -F'\t' '!seen[$2]++' \
    | grep -Ev '/(index|_[^/]*)\.md$' || true
)"
if [[ -n "$CHANGED_RAW" ]]; then
  while IFS= read -r line; do
    [[ -n "$line" ]] && CHANGED+=("$line")
  done <<< "$CHANGED_RAW"
fi

if [[ ${#CHANGED[@]} -eq 0 ]]; then
  echo "No new or modified notes in window."
  exit 0
fi

echo "Found ${#CHANGED[@]} note(s)."

# --- Parse a single note: emit JSON {title, author, description, url, group, status} ---
parse_note() {
  local status="$1" path="$2"
  [[ -f "$path" ]] || return 0  # file deleted after commit

  # Frontmatter block = between the first pair of --- lines at file start.
  local fm body title author
  fm=$(awk 'BEGIN{n=0} /^---$/{n++; if(n==2) exit; next} n==1{print}' "$path")
  body=$(awk 'BEGIN{n=0} /^---$/{n++; next} n>=2{print}' "$path")

  title=$(printf '%s\n' "$fm" | awk -F': *' '/^title:/ {sub(/^title: */,""); gsub(/^["'\'']|["'\'']$/,""); print; exit}')
  author=$(printf '%s\n' "$fm" | awk -F': *' '/^author:/ {sub(/^author: */,""); gsub(/^["'\'']|["'\'']$/,""); print; exit}')

  # First paragraph: skip leading blanks and a single H1/H2, then collect until blank.
  local first_para
  first_para=$(printf '%s\n' "$body" | awk '
    BEGIN{ started=0 }
    /^[[:space:]]*$/ { if (started) exit; next }
    /^#/ && !started { next }
    { buf = (buf ? buf " " : "") $0; started=1 }
    END { print buf }
  ')

  # Trim and cap description to 280 chars.
  first_para=$(printf '%s' "$first_para" | sed -E 's/[[:space:]]+/ /g; s/^ +| +$//g')
  if [[ ${#first_para} -gt 280 ]]; then
    first_para="${first_para:0:277}…"
  fi

  # Derive slug and group from path. Quartz maps content/foo/bar.md -> /foo/bar.
  local slug group
  slug="${path#content/}"
  slug="${slug%.md}"

  case "$path" in
    content/tom/*)   group="tom" ;;
    content/brian/*) group="brian" ;;
    content/notes/*) group="shared" ;;
    *)               group="shared" ;;
  esac

  # If frontmatter author overrides, prefer it for grouping (only if it matches a known key).
  case "$(printf '%s' "${author:-}" | tr '[:upper:]' '[:lower:]')" in
    tom)   group="tom" ;;
    brian) group="brian" ;;
  esac

  [[ -z "$title" ]] && title="${slug##*/}"

  jq -n \
    --arg title "$title" \
    --arg author "${author:-}" \
    --arg description "${first_para:-(no preview)}" \
    --arg url "${SITE_URL}/${slug}" \
    --arg group "$group" \
    --arg status "$status" \
    '{title:$title, author:$author, description:$description, url:$url, group:$group, status:$status}'
}

# Build an array of note JSON objects.
NOTES_JSON="["
first=1
for row in "${CHANGED[@]}"; do
  status="${row%%	*}"
  path="${row#*	}"
  note=$(parse_note "$status" "$path") || continue
  [[ -z "$note" ]] && continue
  if [[ $first -eq 1 ]]; then
    NOTES_JSON+="$note"; first=0
  else
    NOTES_JSON+=",$note"
  fi
done
NOTES_JSON+="]"

# Colors (Discord integer RGB).
COLOR_SHARED=16100384   # #F5A623 amber
COLOR_TOM=4886754       # #4A90E2 blue
COLOR_BRIAN=8314145     # #7ED321 green

# Build up to 10 embeds per message (Discord limit).
EMBEDS=$(printf '%s' "$NOTES_JSON" | jq --argjson cs $COLOR_SHARED --argjson ct $COLOR_TOM --argjson cb $COLOR_BRIAN '
  map({
    title: ((if .status == "A" then "🌱 " else "✏️ " end) + .title),
    description: .description,
    url: .url,
    color: (if .group == "tom" then $ct elif .group == "brian" then $cb else $cs end),
    author: { name: (if .group == "tom" then "Tom" elif .group == "brian" then "Brian" else "Shared" end) }
  })
')

# Assemble message.
COUNT=$(printf '%s' "$NOTES_JSON" | jq 'length')
HEADER="**Little Futures — weekly brief** · ${COUNT} note$([ "$COUNT" = "1" ] || echo s) in the last ${WINDOW}"

PAYLOAD=$(jq -n \
  --arg username "Little Futures Bot" \
  --arg content "$HEADER" \
  --argjson embeds "$EMBEDS" \
  '{
    username: $username,
    content: $content,
    embeds: ($embeds[0:10]),
    allowed_mentions: { parse: [] }
  }')

if [[ $DRY_RUN -eq 1 ]]; then
  echo "--- DRY RUN ---"
  echo "$PAYLOAD" | jq .
  exit 0
fi

RESP=$(mktemp)
trap 'rm -f "$RESP"' EXIT

HTTP=$(curl -sS -o "$RESP" -w "%{http_code}" \
  -H "Content-Type: application/json" \
  -X POST "$DISCORD_BRIEFING_WEBHOOK" \
  --data "$PAYLOAD")

if [[ "$HTTP" != "204" ]]; then
  echo "Discord returned HTTP $HTTP" >&2
  cat "$RESP" >&2
  exit 1
fi

mkdir -p .claude
date -u +"%Y-%m-%dT%H:%M:%SZ" > "$LAST_RUN_FILE"
echo "Posted $COUNT note(s) to Discord."
