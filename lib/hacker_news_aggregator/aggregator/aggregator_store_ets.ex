defmodule HackerNewsAggregator.Aggregator.AggregatorStoreEts do
  use GenStage

  require Logger

  alias HackerNewsAggregator.Aggregator.AggregatorScraper

  def start_link, do: start_link([])
  def start_link(_), do: GenStage.start_link(__MODULE__, :ok, name: __MODULE__)

  @impl true
  def init(_) do
    :ets.new(:top_stories, [:set, :protected, :named_table])
    :ets.insert_new(:top_stories, {:hacker_news, []})
    {:producer_consumer, nil, subscribe_to: [AggregatorScraper]}
  end

  @impl true
  def handle_events(events, _from, state) do
    Enum.each(events, fn x -> store_stories(x) end)

    {:noreply, [events], state}
  end

  @spec store_stories(list()) :: boolean
  defp store_stories(stories) do
    :ets.insert(:top_stories, {:hacker_news, stories})
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, _pid, _reason}, state) do
    :ets.delete(:top_stories)
    {:noreply, state}
  end
end
