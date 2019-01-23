defmodule Megalithic.BlogPostRetriever do
  def retrieve do
    case File.ls("priv/posts") do
      {:ok, files} ->
        files
        |> Enum.map(&Megalithic.BlogPost.compile/1)
        |> Enum.sort(&sort/2)

      {:error, _reason} ->
        File.mkdir_p!("priv/posts")
    end
  end

  def sort(a, b) do
    Calendar.Date.diff(a.date, b.date) > 0
  end
end
