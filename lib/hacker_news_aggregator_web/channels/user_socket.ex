defmodule HackerNewsAggregatorWeb.UserSocket do
  use Phoenix.Socket

  alias HackerNewsAggregator.RateLimiter
  ## Channels
  # channel "room:*", HackerNewsAggregatorWeb.RoomChannel
  channel "top_stories:lobby", HackerNewsAggregatorWeb.TopStoriesChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(_params, socket, connect_info) do
    case get_ip_address(connect_info) |> RateLimiter.log() do
      :ok ->
        socket = assign(socket, :ip_address, get_ip_address(connect_info))
        {:ok, socket}

      _ ->
        :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     HackerNewsAggregatorWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(_socket), do: nil

  defp get_ip_address(%{x_headers: headers_list}) do
    header = Enum.find(headers_list, fn {key, _val} -> key == "x-real-ip" end)

    case header do
      nil ->
        nil

      {_key, value} ->
        value

      _ ->
        nil
    end
  end

  defp get_ip_address(_) do
    nil
  end
end
