defmodule HackerNewsAggregatorWeb.AggregatorController do
  use HackerNewsAggregatorWeb, :controller

  alias HackerNewsAggregator.Aggregator
  alias HackerNewsAggregator.Utils.Pagination

  def top_stories(conn, %{"page" => page} = params) do
    top_stories =
      Aggregator.get_hacker_news_top_stories()
      |> Pagination.paginate(String.to_integer(page))

    case top_stories do
      [] ->
        conn
        |> put_status(404)
        |> json(%{detail: "Not Found"})

      _ ->
        json(conn, top_stories)
    end
  end

  def top_stories(conn, _params) do
    top_stories =
      Aggregator.get_hacker_news_top_stories()
      |> Pagination.paginate(1)

    json(conn, top_stories)
  end
end
