use Mix.Config

config :micro, Micro.Endpoint,
	http: [port: 4000],
	debug_errors: true,
	code_reloader: false,
	cache_static_lookup: false,
	check_origin: false,
	watchers: []

# Watch static and templates for browser reloading.
config :micro, Micro.Endpoint,
	live_reload: []

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :micro, Micro.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "micro_dev",
  hostname: "localhost",
  pool_size: 10