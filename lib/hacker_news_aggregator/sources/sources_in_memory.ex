defmodule HackerNewsAggregator.Sources.InMemory do
  @spec hacker_news_api_top_stories(integer) :: list
  def hacker_news_api_top_stories(_amount) do
    [%{id: :rand.uniform(100)}, %{id: :rand.uniform(100)}]
  end

  @spec hacker_news_api_top_stories!(integer) :: list
  def hacker_news_api_top_stories!(_amount) do
    [%{id: :rand.uniform(1000)}, %{id: :rand.uniform(100)}]
  end
end
