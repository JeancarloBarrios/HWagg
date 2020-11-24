defmodule HackerNewsAggregator.Sources.HackerNewsClient do
  @moduledoc """
  HackerNewsClient is responsible for all Hacker News API call 
  documentation for hacker news api cand be found here https://github.com/HackerNews/API .
  """
  alias Finch.Response
  @hacker_news_host "https://hacker-news.firebaseio.com"

  @doc """
  Gets the top items 
  ## Parameter
     - amount: integer between 1 and 500

  """
  @spec get_top_items(integer) :: list(map())
  def get_top_items(amount) when amount < 501 or amount > 0 do
    :get
    |> Finch.build("#{@hacker_news_host}/v0/topstories.json")
    |> Finch.request(FinchClient)
    |> decode_response
    |> Enum.take(amount)
    |> Task.async_stream(&get_item/1, max_concurrency: 50, on_timeout: :kill_task)
    |> Enum.map(fn {:ok, item} -> item end)
    |> validate_count(amount)
  end

  @doc """
  Gets the item
  ## Parameter
     - id: integer

  """
  @spec get_item(integer) :: map()
  def get_item(id) do
    :get
    |> Finch.build("#{@hacker_news_host}/v0/item/#{id}.json")
    |> Finch.request(FinchClient)
    |> decode_response
  end

  @spec decode_response({:ok, %Response{body: binary}}) :: map()
  defp decode_response({:ok, %Response{body: body}}) do
    body
    |> Jason.decode!(keys: :atoms)
  end

  defp decode_response({:ok, %Response{body: nil}}) do
    nil
  end

  @spec validate_count(list(), integer) :: list()
  defp validate_count(items, amount) do
    case Enum.count(items) == amount do
      true ->
        items

      false ->
        raise "Did no retrieve all items"
    end
  end
end
