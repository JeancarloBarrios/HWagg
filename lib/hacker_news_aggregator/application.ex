defmodule HackerNewsAggregator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HackerNewsAggregatorWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HackerNewsAggregator.PubSub},
      # Start the Endpoint (http/https)
      HackerNewsAggregatorWeb.Endpoint,
      # Start a worker by calling: HackerNewsAggregator.Worker.start_link(arg)
      # {HackerNewsAggregator.Worker, arg}

      {Finch,
       name: FinchClient,
       pools: %{
         "https://hacker-news.firebaseio.com" => [size: 10, count: 5]
       }},
      HackerNewsAggregator.Aggregator.AggregatorSupervisor,
      {PlugAttack.Storage.Ets,
       name: HackerNewsAggregator.PlugAttack.Storage, clean_period: 60_000}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HackerNewsAggregator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HackerNewsAggregatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
