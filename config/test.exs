import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :dert_gg, DertGG.Repo,
  username: System.get_env("PSQL_USERNAME"),
  password: System.get_env("PSQL_PASSWORD"),
  database: "dert_gg_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dert_gg_web, DertGGWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :dert_gg_web, DertGGWeb.Mailer, adapter: Swoosh.Adapters.Test

config :sentry,
  environment_name: :test,
  send_result: :sync
