defmodule HackerNewsAggregator.AggregatorTest do
  use ExUnit.Case

  alias HackerNewsAggregator.Aggregator
  alias HackerNewsAggregator.Sources.InMemory

  test "test data is being saved" do
    stories = Aggregator.get_hacker_news_top_stories()
    assert stories |> Enum.count() == InMemory.hacker_news_api_top_stories!(5) |> Enum.count()
  end
end
