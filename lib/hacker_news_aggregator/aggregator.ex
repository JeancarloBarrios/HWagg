defmodule HackerNewsAggregator.Aggregator do
  @moduledoc """
  The Aggregator context.
  """

  @spec get_hacker_news_top_stories() :: list
  def get_hacker_news_top_stories() do
    [hacker_news: top_stories] = :ets.lookup(:top_stories, :hacker_news)
    top_stories
  end
end
