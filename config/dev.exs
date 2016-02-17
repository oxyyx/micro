use Mix.Config

config :micro, Micro.Endpoint,
	http: [port: 4000],
	debug_errors: true,
	code_reloader: true,
	cache_static_lookup: false,
	check_origin: false,
	watchers: [node: ["node_modules/gulp/bin/gulp.js", "watch"]]

# Watch static and templates for browser reloading.
config :micro, Micro.Endpoint,
	live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

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