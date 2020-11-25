# defmodule HackerNewsAggregator.SourcesTest do
#   use ExUnit.Case
#   doctest HackerNewsClient

#   alias HackerNewsAggregator.Sources.HackerNewsClient

#   test "test hacker news api get top item" do
#     amount = 5
#     items = HackerNewsClient.get_top_items(amount)
#     item_count = Enum.count(items)
#     assert amount == item_count
#   end
# end
