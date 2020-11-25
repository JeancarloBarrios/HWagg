defmodule HackerNewsAggregatorWeb.AggregatorControllerTest do
  use HackerNewsAggregatorWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "get_hacker_news_top_stories" do
    test "list all top stories", %{conn: conn} do
      response = get(conn, "/api/get-hacker-news-top-stories")
      assert response.status == 200
      assert response.resp_body |> Jason.decode!() |> is_list()
    end
  end
end
