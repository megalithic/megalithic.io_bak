defmodule Megalithic.BlogPostRetriever do
  def retrieve do
    File.ls!("priv/posts")
    |> Enum.map(&Megalithic.BlogPost.compile/1)
    |> Enum.sort(&sort/2)
  end

  def sort(a, b) do
    Timex.Duration.diff(a.date, b.date) > 0
  end
end
