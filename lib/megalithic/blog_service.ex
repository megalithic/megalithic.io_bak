defmodule Megalithic.BlogService do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    posts = Megalithic.BlogPostRetriever.retrieve()
    {:ok, posts}
  end

  def handle_call({:list}, _from, posts) do
    {:reply, {:ok, posts}, posts}
  end

  def handle_call({:get_by_slug, slug}, _from, posts) do
    case Enum.find(posts, fn p -> p.slug == slug end) do
      nil -> {:reply, :not_found, posts}
      post -> {:reply, {:ok, post}, posts}
    end
  end

  def list() do
    GenServer.call(__MODULE__, {:list})
  end

  def get_by_slug(slug) do
    GenServer.call(__MODULE__, {:get_by_slug, slug})
  end
end
