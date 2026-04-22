---
description: Post a briefing of recent notes to the Little Futures Discord channel.
argument-hint: "[window] [--dry-run]  e.g. 7d  |  14d  |  since-last  |  7d --dry-run"
allowed-tools: Bash(scripts/brief.sh:*)
---

# Brief the Discord channel

Run the briefing script with the provided arguments. Default window is `7d`. Pass `--dry-run` to preview the payload without posting.

!`scripts/brief.sh $ARGUMENTS`

After the script runs, summarize the result for me in one sentence: how many notes, what window, and whether it was posted or a dry run. If the script exits non-zero, surface the error and suggest a fix (common causes: missing `.env`, stale webhook, Discord rate limit).
