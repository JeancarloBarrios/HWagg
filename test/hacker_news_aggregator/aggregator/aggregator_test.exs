# defmodule HackerNewsAggregator.AggregatorTest do
#   use ExUnit.Case

#   setup do
#     {:ok, _, socket} =
#       HackerNewsAggregatorWeb.UserSocket
#       |> socket("user_id", %{some: :assign})
#       |> subscribe_and_join(HackerNewsAggregatorWeb.TopStoriesChannel, "top_stories:lobby")

#     %{socket: socket}
#   end

#   test "test hacker news api get top item" do
#     amount = 5
#     items = HackerNewsClient.get_top_items(amount)
#     item_count = Enum.count(items)
#     assert amount == item_count
#   end
# end
