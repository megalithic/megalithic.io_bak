defmodule MegalithicWeb.BlogPostController do
  use MegalithicWeb, :controller

  def index(conn, _params) do
    {:ok, posts} = Megalithic.BlogService.list()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"slug" => slug}) do
    case Megalithic.BlogService.get_by_slug(slug) do
      {:ok, post} -> render(conn, "show.html", post: post)
      :not_found -> not_found(conn)
    end
  end

  def not_found(conn) do
    conn
    |> put_status(:not_found)
    |> render(Megalithic.ErrorView, "404.html")
  end
end
