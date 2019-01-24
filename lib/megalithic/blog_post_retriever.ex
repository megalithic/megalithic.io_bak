defmodule Megalithic.BlogPostRetriever do
  def retrieve do
    :code.priv_dir(:megalithic)
    |> Path.join("posts")
    |> File.ls!()
    |> Enum.map(&Megalithic.BlogPost.compile/1)
    |> Enum.sort(&sort/2)
  end

  def sort(a, b) do
    Calendar.Date.diff(a.date, b.date) > 0
  end
end
