defmodule MegalithicWeb.PageController do
  use MegalithicWeb, :controller

  def index(conn, _params) do
    {:ok, posts} = Megalithic.BlogService.list()
    render(conn, "index.html", posts: posts)
  end

  def about(conn, _params) do
    render(conn, "about.html")
  end

  def canon(conn, _params) do
    render(conn, "canon.html")
  end

  def setup(conn, _params) do
    render(conn, "setup.html")
  end

  def mercantile(conn, _params) do
    render(conn, "mercantile.html")
  end
end
