defmodule MegalithicWeb.Router do
  use MegalithicWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MegalithicWeb, host: "setup." do
    pipe_through :browser

    get "/", PageController, :setup
  end

  # scope "/", MegalithicWeb, host: "stats." do
  #   pipe_through :browser
  # end

  scope "/", MegalithicWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/canon", PageController, :canon
    get "/mercantile", PageController, :mercantile
    get "/setup", PageController, :setup
    get "/thoughts", BlogPostController, :index
    get "/thoughts/:slug", BlogPostController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", MegalithicWeb do
  #   pipe_through :api
  # end
end
