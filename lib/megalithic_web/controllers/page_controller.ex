defmodule MegalithicWeb.PageController do
  use MegalithicWeb, :controller

  def index(conn, _params) do
    {:ok, posts} = Megalithic.BlogService.list()
    render(conn, "index.html", posts: posts)
  end
end
