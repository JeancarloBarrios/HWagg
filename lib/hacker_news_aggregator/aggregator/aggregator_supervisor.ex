defmodule HackerNewsAggregator.Aggregator.AggregatorSupervisor do
  @moduledoc """
  HackerNewsClient is responsible for all Hacker News API call 
  documentation for hacker news api cand be found here https://github.com/HackerNews/API .
  """
  use Supervisor

  alias HackerNewsAggregator.Aggregator.AggregatorScraper
  alias HackerNewsAggregator.Aggregator.AggregatorStoreEts
  alias HackerNewsAggregator.Aggregator.AggregatorGenerateUpdate

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    children = [
      AggregatorScraper,
      AggregatorStoreEts,
      AggregatorGenerateUpdate
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end
