defmodule Megalithic.MixProject do
  use Mix.Project

  def project do
    [
      app: :megalithic,
      version: "0.1.2",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Megalithic.Application, []},
      extra_applications: [:logger, :runtime_tools, :timex, :yamerl]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:edeliver, "~> 1.6"},
      {:distillery, "~> 2.0.12"},
      {:earmark, "~> 1.3.1"},
      {:timex, "~> 3.5.0"},
      {:yamerl, "~> 0.7.0"}
    ]
  end
end
