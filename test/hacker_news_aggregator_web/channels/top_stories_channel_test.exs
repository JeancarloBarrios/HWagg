defmodule HackerNewsAggregatorWeb.TopStoriesChannelTest do
  use HackerNewsAggregatorWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      HackerNewsAggregatorWeb.UserSocket
      |> socket("user_id", %{ip_address: :test})
      |> subscribe_and_join(HackerNewsAggregatorWeb.TopStoriesChannel, "top_stories:lobby")

    %{socket: socket}
  end

  test "test recieve fetch_stories" do
    {:ok, _, socket} =
      HackerNewsAggregatorWeb.UserSocket
      |> socket("user_id", %{ip_address: :test})
      |> subscribe_and_join(HackerNewsAggregatorWeb.TopStoriesChannel, "top_stories:lobby")

    %{socket: socket}

    assert_push "fetch_stories", msj
  end

  test "test recieve update actions", %{socket: socket} do
    :timer.sleep(2_000)

    assert_broadcast "update_action", msj
  end
end
