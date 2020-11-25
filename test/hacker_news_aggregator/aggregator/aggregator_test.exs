defmodule HackerNewsAggregator.AggregatorTest do
  use ExUnit.Case

  alias HackerNewsAggregator.Aggregator

  test "test data is being saved" do
    stories = Aggregator.get_hacker_news_top_stories()
    assert stories |> Enum.count() > 0
  end

  # TO test generate_update I will connect to the socket and given the in memory change with random check for a broadcast in update_action
end
