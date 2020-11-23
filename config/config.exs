# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :hacker_news_aggregator, HackerNewsAggregatorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0OdwxQqRkj/qT2MaKt5d0K5/WSzfpPl98tIC3nNH0dGuOBce+qIynVnXSL/25IND",
  render_errors: [view: HackerNewsAggregatorWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: HackerNewsAggregator.PubSub,
  live_view: [signing_salt: "uu1mfMcz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
