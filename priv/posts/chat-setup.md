---
title: digital ocean bitlbee and znc setup
date: 2019-01-29
intro: Having recently rebuilt my Digital Ocean droplet, I thought it would be good to document the process, as a beginner's guide, of setting up bitlbee, ZNC, and weechat on a digital ocean droplet.
image: chat-setup.png
---

For the longest time, my Digital Ocean droplet was used for random geeky things, such as a ZNC IRC bouncer, bitlbee, and a few other tools. Well, that changed when I decided to rebuild that droplet for bringing megalithic industries to life. I wiped the droplet clean, and started from scratch; in the process, lost all of my settings (yikes).

So, that just means I have blog post content now.

In an effort to help others wanting to setup a modern day [weechat](https://weechat.org) chat interface, as well as, references for me to go back to should I get squirrely, and wipe my setup again without backing up.

Hopefully, by the end of this post, you'll have a fully working weechat cli interface, that will give you the ability to hook into IRC (via your own ZNC IRC bouncer), bitlbee (for Google Hangouts, among other things), and finally, wee-slack (a great python script that allows for communications with Slack's websockets API).

We're going to just assume that you have a digital ocean droplet all setup and secured.

## Installation of things

#### ZNC

First, we'll want to install ZNC and setup a user to run ZNC under. This also generates a config file for you. It will walk you through some defaults, and let you fill in important details.

```sh
sudo apt install znc znc-dev
sudo useradd --create-home -d /var/lib/znc --system --shell /sbin/nologin --comment "User to run ZNC daemon" --user-group znc
sudo -u znc /usr/bin/znc --datadir=/var/lib/znc --makeconf
```
