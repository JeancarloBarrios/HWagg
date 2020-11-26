defmodule HackerNewsAggregator.Utils.Pagination do
  @page_size 10

  @spec paginate(list(), integer) :: list()
  def paginate(list, page) when page > 0 do
    list
    |> Enum.slice(@page_size * (page - 1), @page_size)
  end

  def paginate(_list, page) when page < 0 do
    []
  end
end
