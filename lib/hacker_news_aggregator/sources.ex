defmodule HackerNewsAggregator.Sources do
  @moduledoc """
  The Sources context.

  """
  alias HackerNewsAggregator.Sources.HackerNewsClient
  @spec hacker_news_api_top_stories(integer) :: list
  def hacker_news_api_top_stories(amount) do
    HackerNewsClient.get_top_items(amount)
  end

  @spec hacker_news_api_top_stories!(integer) :: list
  def hacker_news_api_top_stories!(amount) do
    HackerNewsClient.get_top_items(amount)
    |> validate_count(amount)
  end

  @spec hacker_news_api_get_item(integer) :: map()
  def hacker_news_api_get_item(id) do
    HackerNewsClient.get_item(id)
  end

  @spec validate_count(list(), integer) :: list()
  defp validate_count(items, amount) do
    case Enum.count(items) == amount do
      true ->
        items

      false ->
        raise "Did no retrieve all items"
    end
  end
end
