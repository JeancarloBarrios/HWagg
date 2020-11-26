defmodule HackerNewsAggregator.Utils do
  alias HackerNewsAggregator.Utils.Pagination

  @doc """
  paginate paginates a list and return a given page page size is 10
  ## parameter
     - list -> any list of a values
     - page -> integer
  """
  @spec paginate(list(), integer) :: list()
  def paginate(list, page), do: Pagination.paginate(list, page)
end
