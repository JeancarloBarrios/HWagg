use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hacker_news_aggregator, HackerNewsAggregatorWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :hacker_news_aggregator, :sources, HackerNewsAggregator.Sources.InMemory

config :hacker_news_aggregator, :scraper_interval, 1_000
