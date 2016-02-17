use Mix.Config

# Secret key
config :micro, Micro.Endpoint,
  secret_key_base: "KEYKEYKEYKEYKEY"
  
# Configure your database
config :micro, Micro.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("MICRO_DB_USER"),
  password: System.get_env("MICRO_DB_PASS"),
  database: System.get_env("MICRO_DB_DATABASE"),
  size: 20