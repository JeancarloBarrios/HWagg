defmodule HackerNewsAggregatorWeb.AggregatorController do
  use HackerNewsAggregatorWeb, :controller

  alias HackerNewsAggregator.Aggregator
  alias HackerNewsAggregator.Utils

  def top_stories(conn, params) do
    page = Map.get(params, "page", "1")

    top_stories =
      Aggregator.get_hacker_news_top_stories()
      |> Utils.paginate(String.to_integer(page))

    case top_stories do
      [] ->
        conn
        |> put_status(404)
        |> json(%{detail: "Not Found"})

      _ ->
        json(conn, top_stories)
    end
  end
end
