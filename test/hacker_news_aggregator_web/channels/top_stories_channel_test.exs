defmodule HackerNewsAggregatorWeb.TopStoriesChannelTest do
  use HackerNewsAggregatorWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      HackerNewsAggregatorWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(HackerNewsAggregatorWeb.TopStoriesChannel, "top_stories:lobby")

    %{socket: socket}
  end

  # TO test generate_update I will connect to the socket and given the in memory change with random check for a broadcast in update_action
end
