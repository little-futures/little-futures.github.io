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

Push to the `v4` branch. GitHub Actions will build and deploy automatically.
