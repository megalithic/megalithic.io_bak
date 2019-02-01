defmodule MegalithicWeb.LayoutView do
  use MegalithicWeb, :view

  def robots(conn) do
    case conn.assigns[:robots] do
      nil -> "INDEX,FOLLOW"
      robots -> robots
    end
  end

  def title(conn) do
    case conn.assigns[:title] do
      nil -> "megalithic industries"
      title -> "#{title} | megalithic industries"
    end
  end

  def description(conn) do
    case conn.assigns[:description] do
      nil -> ""
      description -> description
    end
  end

  def keywords(conn) do
    case conn.assigns[:keywords] do
      nil ->
        "irc,weechat,wechat,whatsapp,rtc,freenode,wee-chat,slack,bitlbee,google,hangouts,google hangouts,wee-slack,wee_slack,weeslack,python,purple,gtalk,jabber,xmpp,digital ocean,droplet,do,znc,bouncer,ubuntu,18.04,setup,connect,setup,config,configurations,connections,service,services,ubuntu 18.04,ubuntu 16.04,daemon,websocket,websockets,api,real time chat,real-time,cli,command,command-line,interface,command line interface,tool,tools,oss,opensource,open-source,open source,github,git,version control,mercurial,hg,vcs,dotfiles,dots,files,python,pip,readme,systemd,initd,etc,mac,apple,macos,mojave,sierra,high sierra,macosx,osx,mac os,mac osx,chat,token,register,registration,megalithic,megalith,megalithic industries,monolith,easter island,design,designer,phoenix,elixir,vim,tmux,nvim,neovim,development,software,engineering,software engineer,developer,front-end,front end,back-end,back end,server,ssh,secure shell,secure,shell,zsh,bash,sh,fish,z-shell"

      keywords ->
        keywords
    end
  end
end
