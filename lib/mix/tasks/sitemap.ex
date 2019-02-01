defmodule Mix.Tasks.Sitemap do
  @moduledoc """
  Generates a static sitemap.
  """

  use Mix.Task

  def run(_) do
    # Don't require a running HTTP server
    Application.put_env(:phoenix, :serve_endpoints, false, persistent: true)

    # Don't start any repos
    Application.put_env(:megalithic, :ecto_repos, [])

    # Start the application
    Mix.Task.run("app.start", [])

    # Start the Sitemap process
    Sitemap.start(nil, nil)

    # Generate the sitemap
    MegalithicWeb.Sitemap.generate()
  end
end
