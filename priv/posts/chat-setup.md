---
title: digital ocean bitlbee and znc setup
date: 2019-01-29
intro: Having recently rebuilt and setup my webserver, I thought it would be good to document the process, as a beginner's guide, of setting up bitlbee, ZNC, and weechat on a Digital Ocean droplet.
image: chat-setup.png
---

For the longest time, my [Digital Ocean](https://m.do.co/c/6abe22c9c487) droplet was used for random geeky things, such as a [ZNC IRC bouncer](https://wiki.znc.in/ZNC), [bitlbee](https://www.bitlbee.org), and a few other tools. Well, that changed when I decided to rebuild that droplet for bringing megalithic industries to life. I wiped the droplet clean, and started from scratch; in the process, I lost all of my settings (yikes).

So, that just means I have blog post content now; all in an effort to help others wanting to setup a modern day [weechat](https://weechat.org) chat interface, as well as to provide references for me to go back to should I get squirrely, and wipe my setup again without backing up.

Hopefully, by the end of this post, you'll have a fully working weechat CLI interface, that will give you the ability to hook into IRC (via your own ZNC IRC bouncer), [bitlbee](https://www.bitlbee.org) (for Google Hangouts, among other things), and finally, [wee-slack](https://github.com/wee-slack/wee-slack) (a great python script that allows for communications with Slack's websockets API).

We're going to just assume that you have a [Digital Ocean](https://m.do.co/c/6abe22c9c487) droplet [all setup and secured](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-18-04).

## ZNC

Let's install [ZNC](https://wiki.znc.in/ZNC) and setup a user to run ZNC under. This also generates a config file for you. It will walk you through some defaults, and let you fill in important details. As part of those details, let's go ahead and setup [freenode](https://freenode.net) as our initial IRC server, and remember the port you set for ZNC (we'll assume 5000).


#### Installation

```bash
cd ~
sudo apt install -y znc znc-dev
sudo useradd --create-home -d /var/lib/znc --system --shell /sbin/nologin --comment "User to run ZNC daemon" --user-group znc
sudo -u znc /usr/bin/znc --datadir=/var/lib/znc --makeconf
```

Before we continue with setting up ZNC configs, let's make sure it auto-launches anytime our droplet restarts..

First, create a systemd service: `sudo vim /etc/systemd/system/znc.service`

Use the following service config:

```ini
[Unit]
Description=ZNC Service
After=network-online.target

[Service]
ExecStart=/usr/bin/znc -f --datadir=/var/lib/znc
User=znc

[Install]
WantedBy=multi-user.target
```

Reload the daemon and enable ZNC service

```bash
sudo systemctl daemon-reload
sudo systemctl enable znc
```

#### Configuration

With installation done we need to setup our main ZNC user and all of its config.

First, let's try visiting the ZNC web config panel at http://<digital_ocean_ip>:5000.

From here you should be able to log in with the user and password you defined during initial ZNC setup.

Next, you'll want to click the "Your Settings" link from the web interface. You can now easily change the password if you want, along with all the other settings for Freenode, including setting up the channels to always connect to. You can also setup `nickserv` module to automatically identify you and your preferred nick. Dope!


#### Weechat

Last thing to do is setup weechat to connect to your ZNC server for all your IRC needs!

We're going to assume you already have weechat installed on your OS of choice (for macOS: `brew install weechat`).

From within weechat, we're going to add a server for freenode, and set it up to auto-connect for us..

```
/server add freenode <digital_ocean_ip>/<port_we_set_above_for_znc> -autoconnect
/connect freenode
/save
```

Assuming you setup the `nickserv` module in ZNC, as well as some initial channels to connect to, it should just auto-connect and auto-join freenode and those channels. We're done with ZNC/IRC.


## Bitlbee

Now that we have IRC things taken care of with ZNC, let's install [bitlbee](https://www.bitlbee.org) and libpurple so that we can get Google Hangouts working with weechat. We'll need to use Mercurial for version control for connecting the dots between libpurple and hangouts. Finally, we'll build the [purple-hangouts](https://bitbucket.org/EionRobb/purple-hangouts/overview) project.

#### Installation

```bash
cd ~
sudo mkdir -p /var/lib/bitlbee
sudo apt-get install -y python-pip python-potr bitlbee-common bitlbee-libpurple bitlbee-plugin-otr libpurple-dev libjson-glib-dev libglib2.0-dev libprotobuf-c-dev protobuf-c-compiler mercurial make
mkdir src
cd src
hg clone https://bitbucket.org/EionRobb/purple-hangouts/ && cd purple-hangouts;
make && sudo make install
```

Before we get to configuring bitlbee further, let's make sure it relaunches upon restarting our droplet.

First, create a systemd service: `sudo vim /lib/systemd/system/bitlbee.service`

Use the following service config:

```ini
[Unit]
Description=BitlBee IRC/IM gateway

[Service]
ExecStart=/usr/sbin/bitlbee -F -n
KillMode=process

[Install]
WantedBy=multi-user.target
```

Reload the daemon and enable bitlbee service

```bash
sudo systemctl daemon-reload
sudo systemctl enable bitlbee
```

#### Configuration

Ok, let's quickly configure our bitlbee instance: `sudo vim /etc/bitlbee/bitlbee.conf`

I prefer these settings:

```ini
[settings]
RunMode = ForkDaemon
User = bitlbee
DaemonInterface = 0.0.0.0
DaemonPort = 5001
AuthMode = Open
[defaults]
```

#### Weechat

Configuration of bitlbee and purple-hangouts should be done, so now we just need to connect it up to weechat. We're going to assume you already have weechat installed on your OS of choice (for macOS: `brew install weechat`).

We'll setup a hangouts server (could be called anything you want). Next we'll connect to it, then we'll register a super_secret_password. Lastly we'll setup weechat to auto log us in each time.

```
/server add hangouts <digital_ocean_ip>/<port_we_set_above_for_bitlbee> -autoconnect
/connect hangouts
register <super_secret_password>
/set irc.server.hangouts.command "/msg &bitlbee /OPER identify <super_secret_password>"
/save
```

Now we need to setup Google Hangouts for bitlbee/purple. Let's do that now, while we have the &bitlbee buffer selected in weechat.

```
acc add hangouts your-gmail-account@gmail.com
acc hangouts on
```

You'll be presented with a private message from `purple_request_0`. It prompts you to visit a YouTube video to watch to get the `oauth_code` to respond with in the PM. Once you enter the oauth_code, you're done, it'll connect you.

Lastly we need to save our configs in weechat/bitlbee!

For bitlbee, while you're still in the bitlbee buffer: `save`

For weechat, from any buffer: `/save`


## Fin!

That's it! You should now have a running ZNC server and bitlbee server on your [Digital Ocean](https://m.do.co/c/6abe22c9c487) droplet, as well as your local weechat instance auto-connecting to both bitlbee and ZNC.

Happy CLI chatting!


### Links

- [Digital Ocean](https://m.do.co/c/6abe22c9c487)
- [Initial droplet setup for Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-18-04)
- [weechat](https://weechat.org)
- [ZNC](https://wiki.znc.in/ZNC)
- [freenode](https://freenode.net)
- [bitlbee](https://bitlbee.org)
- [purple-hangouts](https://bitbucket.org/EionRobb/purple-hangouts/overview)
- [wee-slack](https://github.com/wee-slack/wee-slack)
