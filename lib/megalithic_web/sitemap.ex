defmodule MegalithicWeb.Sitemap do
  @moduledoc """
  Defines and generates a static sitemap.
  """

  use Sitemap,
    compress: false,
    host: "https://megalithic.io",
    files_path: "priv/sitemaps",
    public_path: "sitemaps/"

  alias MegalithicWeb.Endpoint
  alias MegalithicWeb.Router.Helpers, as: Routes

  def generate do
    create do
      add(Routes.page_path(Endpoint, :index), priority: 0.5, changefreq: "hourly")
      add(Routes.page_path(Endpoint, :about), priority: 0.5, changefreq: "hourly")
      add(Routes.page_path(Endpoint, :canon), priority: 0.5, changefreq: "hourly")
      add(Routes.page_path(Endpoint, :setup), priority: 0.5, changefreq: "hourly")
      add(Routes.page_path(Endpoint, :mercantile), priority: 0.5, changefreq: "hourly")
      add(Routes.blog_post_path(Endpoint, :index), priority: 0.5, changefreq: "hourly")
      # add(Routes.blog_post_path(Endpoint, :show), priority: 0.5, changefreq: "hourly")
    end
  end
end
