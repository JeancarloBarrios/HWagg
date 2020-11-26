defmodule HackerNewsAggregatorWeb.Plug.RateLimiterPlug do
  # We use Plug.Builder to have access to the plug/2 macro.
  # This macro can receive a function or a module plug and an
  # optional parameter that will be passed unchanged to the 
  # given plug.
  # use Plug.Builder
  import Plug.Conn
  alias HackerNewsAggregator.RateLimiter

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case RateLimiter.log(conn.remote_ip) do
      :ok ->
        conn

      _ ->
        conn
        |> resp(401, "Rate Limited")
        |> halt
    end
  end
end
