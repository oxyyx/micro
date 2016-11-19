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
        :timex,
        :phoenix_pubsub
      ]
    ]
  end

  # Paths per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.2.0"},
      {:phoenix_ecto, "~> 3.0-rc"},
      {:phoenix_pubsub, "~> 1.0"},
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
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test":       ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
