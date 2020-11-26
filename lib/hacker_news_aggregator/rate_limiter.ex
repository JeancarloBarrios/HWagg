defmodule HackerNewsAggregator.RateLimiter do
  alias HackerNewsAggregator.RateLimiter.RateLimiterEts

  @doc """
  log it adds a counter for rate limiting
  ## parameter
     - uid -> any term that is unique to use as key (ip_address)
  """
  @spec(log(term) :: :ok, {:error, :rate_limited})
  def log(uid) do
    RateLimiterEts.log(uid)
  end
end
