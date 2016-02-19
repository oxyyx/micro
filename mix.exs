defmodule Micro.Mixfile do
  use Mix.Project

  # Project information.
  def project do
    [
      app: :micro,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases,
      deps: deps
    ]
  end

  # Configuration for the OTP application.
  def application do
    [
      mod: {Micro, []},
      applications: 
      [
        :phoenix, 
        :phoenix_html, 
        :cowboy, 
        :logger, 
        :gettext,
        :phoenix_ecto, 
        :postgrex, 
        :timex
      ]
    ]
  end

  # Paths per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.1"},
      {:phoenix_ecto, "~> 2.0"},
      {:postgrex, "~> 0.11.0"},
      {:phoenix_html, "~> 2.3"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.9"},
      {:cowboy, "~> 1.0"},
      {:timex, "~> 1.0.1"}
   ]
  end

  # Mix aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
