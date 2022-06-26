import Config

# Configure Mix tasks and generators
config :dert_gg,
  namespace: DertGG,
  ecto_repos: [DertGG.Repo]

config :dert_gg_web,
  namespace: DertGGWeb,
  ecto_repos: [DertGG.Repo],
  generators: [context_app: :dert_gg]

# Configures the endpoint
config :dert_gg_web, DertGGWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D+MwgY1nCbumtXQH6FqrykwSMGq/FtUVC2AYhfX2SAJaIpkIW5wbLrgtDRUDALkQ",
  render_errors: [view: DertGGWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DertGG.PubSub,
  live_view: [signing_salt: "ksLtQzcf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Swoosh config
config :dert_gg_web, DertGGWeb.Mailer,
  adapter: Swoosh.Adapters.Sendinblue,
  api_key: System.get_env("SENDINBLUE_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
