defmodule HackerNewsAggregator.Sources.InMemory do
  @spec hacker_news_api_top_stories(integer) :: list
  def hacker_news_api_top_stories(_amount) do
    [%{id: :rand.uniform(100), test: true}, %{id: :rand.uniform(100), test: true}]
  end

  @spec hacker_news_api_top_stories!(integer) :: list
  def hacker_news_api_top_stories!(_amount) do
    [%{id: :rand.uniform(100), test: true}, %{id: :rand.uniform(100), test: true}]
  end
end
