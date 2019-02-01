defmodule Megalithic.BlogPost do
  defstruct slug: "",
            title: "",
            date: "",
            intro: "",
            content: "",
            image: "",
            keywords: ""

  def compile(file) do
    post = %Megalithic.BlogPost{
      slug: file_to_slug(file)
    }

    :code.priv_dir(:megalithic)
    |> Path.join(["posts/", file])
    |> File.read!()
    |> split
    |> extract(post)
  end

  defp file_to_slug(file) do
    String.replace(file, ~r/\.md$/, "")
  end

  defp split(data) do
    [frontmatter, markdown] = String.split(data, ~r/\n-{3,}\n/, parts: 2)
    {parse_yaml(frontmatter), Earmark.as_html(markdown)}
  end

  defp parse_yaml(yaml) do
    [parsed] = :yamerl_constr.string(yaml)
    parsed
  end

  defp extract({props, content}, post) do
    %{
      post
      | title: get_prop(props, "title"),
        date: get_prop(props, "date") |> Calendar.Date.Parse.iso8601!(),
        intro: get_prop(props, "intro"),
        image: get_prop(props, "image") && get_prop(props, "image"),
        content: content,
        keywords: get_prop(props, "keywords") && get_prop(props, "keywords")
    }
  end

  defp get_prop(props, key) do
    case :proplists.get_value(String.to_charlist(key), props) do
      :undefined -> nil
      x -> to_string(x)
    end
  end
end
