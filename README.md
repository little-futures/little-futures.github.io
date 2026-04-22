# Little Futures

A shared digital garden by Tom Critchlow and Brian Dell, published at [little-futures.github.io](https://little-futures.github.io).

## How it works

- Write notes in [Obsidian](https://obsidian.md)
- Push to this repo
- [Quartz](https://quartz.jzhao.xyz) builds and deploys via GitHub Actions

## Content structure

```
content/
├── notes/          # Shared notes (frontmatter specifies author)
├── pages/          # Static pages (about, etc.)
├── tom/            # Tom's personal space
│   ├── notes/
│   ├── links/
│   └── music/
└── brian/          # Brian's personal space
    ├── notes/
    ├── links/
    └── music/
```

## Local development

```bash
npm i
npx quartz build --serve
```

## Publishing

Push to the `master` branch. GitHub Actions will build and deploy automatically.

## Weekly Discord brief

A GitHub Actions workflow posts a summary of new and edited notes to our Discord channel every Monday at 14:00 UTC (~10am ET during EDT, ~9am ET during EST). Source: `scripts/brief.sh` + `.github/workflows/brief.yml`.

**To trigger a run on demand:**

- **Zero-setup (recommended):** Actions tab → "Weekly Discord brief" → Run workflow. Or `gh workflow run brief.yml -f window=30d`.
- **From a local clone:** copy `.env.example` to `.env`, paste the webhook URL (ask a maintainer), then `./scripts/brief.sh 7d` — or `/brief` if you're using Claude Code in this repo.

The webhook URL is stored as the `DISCORD_BRIEFING_WEBHOOK` Actions secret for scheduled/dispatched runs; locally it's read from `.env` (gitignored).
