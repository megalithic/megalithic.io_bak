---
title: Building blocks
date: 2019-01-24
intro: A lot has gone in to making this site come to life, we're going to take a look at the various aspects of putting it all together.
image: building-blocks.jpg
---

From the beginning, for this site, I knew I wanted to use the tech stack I presently use at work. That, thankfully, involves fun langs, such as [elixir](https://elixir-lang.org) and [elm](https://elm-lang.org). I also wanted to avoid off-the-shelf solutions for a blogging engine, deployment strategies, etc.

### The stack

As mentioned, I am currently using elm-lang and elixir-lang at work. I'm also learning those two languages on the job (pretty awesome when an employer allows for this to happen). For now, the guts of megalithic.io is a relatively simple Phoenix web app, with just a small bit of OTP sprinkled in.

The OTP bit, handles the processing of markdown files, that I use to statically generate the blog posts for this site. I found [a magnificent article](http://www.sebastianseilund.com/static-markdown-blog-posts-with-elixir-phoenix) that walks through how one might build such a blogging facility. It is based on an older version of Phoenix, so there was thankfully a bit of pulling up my sleeves to get my hands dirty in modifications to support the latest version of Phoenix.

I currently am not using elm for any portion of the main site (yet), but, it is already being used as the full front-end for my upcoming project, Canon.

### Devving some Ops

I have always had a single Digital Ocean droplet, that I've used for just utility things, like an IRC bouncer, amongst other related services. I figured, why not repurpose this for a proper web server?

So, I set out to find out how others building elixir/phoenix web apps, might go about easily deploying to their own web server. Thankfully, there are a number of strategies for doing this; such as dokku, edeliver, and gatling. I chose the route of distillery + edeliver.
