defmodule HackerNewsAggregatorWeb.TopStoriesChannel do
  use HackerNewsAggregatorWeb, :channel

  alias HackerNewsAggregator.Aggregator

  @impl true
  def join("top_stories:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_info(:after_join, socket) do
    push(socket, "fetch_stories", Aggregator.get_hacker_news_top_stories())

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end