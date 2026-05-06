---
title: "Weekly Thing 346 / Wuphf, Landsat, Eclipse"
source: "https://buttondown.com/weekly-thing/archive/346/"
author:
  - "[[Jamie Thingelstad]]"
published: 2026-05-03
created: 2026-05-03
description: "Podcasting, Claude Code quality reports, Anthropic, Cloudflare accounts, wuphf, Port 22, Micro.blog, MCP Servers."
tags:
  - "clippings"
---
### [Agents can now create Cloudflare accounts, buy domains, and deploy](https://blog.cloudflare.com/agents-stripe-projects/)

This is the first "real" use case I've seen where agents are given access to payment methods and buying something on their own.

> Starting today, agents can provision Cloudflare on behalf of their users. They can create a Cloudflare account, start a paid subscription, register a domain, and get back an API token to deploy code right away. Humans can be in the loop to grant permission and must accept Cloudflare's terms of service, but no human steps are otherwise required from start to finish.

This is specifically done with Stripe.

> This all works via a new protocol that we've co-designed with Stripe as part of the launch of [Stripe Projects](https://projects.dev/).

There is a not-so-subtle signal here that both Stripe and Cloudflare see agents, particularly coding agents, as their customer. If you fire up Codex or Claude Code and say "build me a thing", they want the agents to prefer their platforms because the actual end-user probably doesn't have a strong opinion and the agent is just looking to get the job done. It will likely pick the solution that allows it to do that most completely.

I can’t help but connect this back to crypto too. This solution is fine but it is fully platform lock-in with Stripe enabling it. The better answer, and I nearly guarantee we are going to get here, is giving your agents a crypto wallet and sending digital currency to it to get the job done. No lock in, no worry about the agent having access to your credit card, no risk it overspends, and instant settlement. This is so completely crystal clear and doable today.

**Prediction: digital currency will take off with agent proliferation.**