---
title: "We need RSS for sharing abundant vibe-coded apps"
source: "https://interconnected.org/home/2026/04/29/syndicating-vibes"
author:
published:
created: 2026-05-01
description: "Posted on Wednesday 29 Apr 2026. 1,087 words, 19 links. By Matt Webb."
tags:
  - "clippings"
---
##### 17.58, Wednesday 29 Apr 2026 Link to this post

Now we have abundant apps, we’ve hit a ceiling in good ways to track and share them.

For example, [Simon Willison’s personal tools](https://tools.simonwillison.net/): Miscellaneous HTML+JavaScript tools built mostly with the help of LLMs.

Willison lists 80+ useful tools and the search box can see 205. That’s a lot!

He has hyper-specific tools like one to track daylight savings changes in California, personal software to help build his newsletter from his blog, and a tool to edit using Strunk & White’s principle to [omit needless words](https://tools.simonwillison.net/omit-needless-words). (What’s especially neat is Willison shares the [prompts and chat history behind each tool](https://tools.simonwillison.net/colophon#omit-needless-words.html).)

I keep a note when I see people sharing abundant apps.

- [Matt Sephton shipped 20 macOS apps in a day](https://blog.gingerbeardman.com/2026/04/17/today-i-shipped-twenty-apps-and-a-screensaver/). Everything from a sound effects generator to perspective correction to a language translator with a beautiful interaction: hit cmd-C to copy twice to auto-translate any text.
- [tools.jamesking.io](https://tools.jamesking.io/) – designer James King shares personal web-based tools such as his bookmarked fonts and a custom editor to product his podcast.
- [Britt Crawford’s Home Cooked Software](https://brittcrawford.com/projects/) – including an app to turn any web page into a podcast episode and omg I love Log Weight: Shout at your phone while you’re on the scale and log your weight in Apple Health.

And then there are…

- The untracked apps that fly by on X and blogs. Among these I’ll count my own collaborative Markdown editor [mist](https://mist.inanimate.tech/) and even *Galactic Compass* which [I wouldn’t have written without ChatGPT](https://interconnected.org/home/2024/02/15/galactic-compass). Where are these listed? Nowhere.
- The personal toolkits of Claude skills and workflows that many of us are building up. [How do we manage our agent SKILL.md files? Is it just chaos?](https://x.com/mappletons/status/2048789569189957840) asks Maggie Appleton on X. There’s a corporate side to this too: I’d love to know when [Cloudflare adds more skills to their plugin](https://github.com/cloudflare/skills) or when [headless CLI tools](https://interconnected.org/home/2026/04/18/headless) grow more features.
- The streams of apps vibed on platforms like Lovable and Replit – or on the more personal, situated end of the spectrum: [Essential Apps by Nothing](https://nothing.community/d/52739-essential-apps-enters-beta) for their Android phones, or [Raycast Glaze](https://www.raycast.com/blog/introducing-glaze) for macOS, or [Dreamer](https://dreamer.com/) where you can see some examples of web-based agentic apps but can’t build your own because they were live for a month before being snaffled up by Meta.

This is not even counting the almost-ephemeral prompts to CLI tools like [llm](https://llm.datasette.io/en/stable/) that live only in my terminal history.

So many apps!

---

Not all of these apps are vibe-coded. I don’t think the distinction matters. We’re at a new time of abundance, creativity and personal software and I want ways to keep up with the latest.

---

BUT.

How do I keep a list of the apps I use regularly so I can come back to them?

How do I discover new apps? Let’s say I like a tool by Simon, how do I follow him to see what he comes up with next?

What if Simon improves a tool? How would I know? (And conversely, what if someone makes a malicious update?)

How do I share my recommendations? And make them relevant to the platforms you use – iOS if you’re on iOS, ESP32 if you’re on that and so on.

This was one of my two questions about micro-apps before: [No apps no masters](https://interconnected.org/home/2024/08/09/no-apps-no-masters) (2024):

> If the future is ephemeral AI-created micro apps, then what’s on my home screen?

---

Could we have RSS for vibe-coded apps?

I would love an RSS web feed for all those various tools and apps pages, each item with an “Install” button. (But install to where?)

The lesson here is that when vibe-coding accelerates app development, apps become more personal, more situated, and more frequent. Shipping a tool or a micro-app is less like launching a website and more like posting on a blog.

Posting on a blog is what RSS was made for. You use RSS to subscribe to blogs to keep up with the latest content. ([What is RSS?](https://aboutfeeds.com/))

When I say that maybe we should have RSS for all these apps, what I really mean is the whole ecosystem that flourished back when blogs were young…

- Websites for identity – I want more from this person or this project!
- RSS to subscribe – get the latest
- Newsreaders – to aggregate all my sources
- Social sharing – sites like **del.icio.us** (if you remember that) to share the best of your discoveries and discover more recommendations, a purer ProductHunt
- Search – via Google and Technorati

And tags and all the rest…

The beauty of RSS is that it was used as a simple interop layer: yes there was RSS for blogs. But also there are reverse chronological feeds on all kinds of sites: the New York Times, photo sharing on Flickr, your latest Github stars. And all of those would expose RSS feeds too, so you could subscribe a little like choosing what notifications you allow onto your home screen.

Now the challenge of sharing micro-apps does not exactly map to RSS and web feeds. It’s less about time for one, and apps develop over time, and platforms really matter. But it’s close enough for jazz.

---

In the spirit of [protocol fiction](https://interconnected.org/home/2023/05/19/protocols) it would be fun (or at least illuminating) to sketch out an RSS-like format that would be trivially adopted by everyone from Simon Willison’s tools page to my personal Claude plugin (which is a hodge-podge toolbox where I collect useful skills) to the templates at Lovable.

If you do this:

- Please don’t create a registry that people have to submit their micro-apps to. A file in plain text on their server will do.
- Make it work for all the examples I pointed at above.
- Don’t insist on open source or prompt sharing or 100% vibe coded; allow it to work for macOS binaries with a link to the Mac App Store, web-based tools that can be run instantly, and proprietary vibe coded widgets that only work in certain platforms. Scale all the way down to people just sharing prompts.
- Imagine you are plumbing a future vibrant ecosystem of services for discovery, managing, recommendations, and all the rest. Make it distributed.
- Think about what’s *different* from RSS for blog posts: do we need identity and versions and the ability for people to fork and modify apps?

Above all read Dave Winer’s [Rules for standards-makers](http://scripting.com/2017/05/09/rulesForStandardsmakers.html) – the distillation of how to invent and popularise a protocol for interop from the person who created both RSS and podcasting.

Let me know if you make this. I’d like to use it.