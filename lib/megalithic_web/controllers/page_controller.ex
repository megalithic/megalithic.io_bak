defmodule MegalithicWeb.PageController do
  use MegalithicWeb, :controller

  def index(conn, _params) do
    {:ok, posts} = Megalithic.BlogPostRetriever.list()
    render(conn, "index.html", posts: posts)
  end
end
