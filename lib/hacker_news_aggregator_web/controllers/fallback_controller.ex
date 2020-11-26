defmodule HackerNewsAggregatorWeb.FallbackController do
  use HackerNewsAggregatorWeb, :controller

  # def call(conn, {:error, msg}) when is_binary(msg) do
  #   conn
  #   |> put_flash(:error, msg)
  #   |> redirect(to: album_path(conn, :index))
  # end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{detail: "Not Found"})
  end
end
