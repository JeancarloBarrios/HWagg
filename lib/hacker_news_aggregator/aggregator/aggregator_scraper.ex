defmodule HackerNewsAggregator.Aggregator.AggregatorScraper do
  @moduledoc """
  AggregatorScraper is responsible get_top_stories from hacker news in a given time interval.
  """
  use GenStage

  require Logger

  def start_link, do: start_link([])

  def start_link(_) do
    GenStage.start_link(__MODULE__, {}, name: __MODULE__)
  end

  def init(_) do
    # due to the lack of handle_continue I use send()
    send(self(), :work)
    {:producer, {}}
  end

  def handle_info(:work, state) do
    top_stories = sources().hacker_news_api_top_stories!(50)
    schedule_retrival()

    {:noreply, [top_stories], state}
  end

  def handle_demand(demand, queue) when demand > 0 do
    {:noreply, [], queue}
  end

  def get_state_impl(state), do: {:reply, state, state}

  def handle_call({:get_state}, _from, state) do
    get_state_impl(state)
  end

  defp schedule_retrival do
    Process.send_after(self(), :work, time_to_retrieve())
  end

  defp sources, do: Application.get_env(:hacker_news_aggregator, :sources)

  defp time_to_retrieve, do: Application.get_env(:hacker_news_aggregator, :scraper_interval)
end
