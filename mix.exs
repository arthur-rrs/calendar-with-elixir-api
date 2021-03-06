defmodule Gaibu.MixProject do
  use Mix.Project

  def project do
    [
      app: :gaibu,
      version: "0.1.0",
      elixir: "~> 1.10",
      config_path: "config/#{Mix.env()}.exs",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Gaibu.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:myxql, "~> 0.3.0"},
      {:postgrex, "~> 0.15.3"},
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:guardian, "~> 2.1"},
      {:cors_plug, "~> 2.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
