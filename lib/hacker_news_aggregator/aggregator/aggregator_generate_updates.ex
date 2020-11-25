defmodule HackerNewsAggregator.Aggregator.AggregatorGenerateUpdate do
  use GenStage

  require Logger

  alias HackerNewsAggregator.Aggregator.AggregatorStoreEts

  def start_link, do: start_link([])
  def start_link(_), do: GenStage.start_link(__MODULE__, :ok, name: __MODULE__)

  @impl true
  def init(_) do
    :ets.new(:last_top_stories, [:set, :private, :named_table])
    :ets.insert_new(:last_top_stories, {:hacker_news, []})
    {:consumer, nil, subscribe_to: [AggregatorStoreEts]}
  end

  @impl true
  def handle_events(events, _from, state) do
    Enum.each(events, fn x -> compute_stories(x) end)

    {:noreply, [], state}
  end

  @spec compute_stories(list()) :: boolean
  defp compute_stories(stories) do
    [hacker_news: top_stories] = :ets.lookup(:last_top_stories, :hacker_news)
    {actions, new_stories} = compare_stories(top_stories, stories)
    broadcast_update(actions)
    store_stories(new_stories)
  end

  @spec compare_stories(list, list) :: {list, list}
  defp compare_stories([], new_stories) do
    actions = Enum.map(new_stories, fn x -> %{action: "add", item: x} end)
    {actions, new_stories}
  end

  defp compare_stories(old_stories, new_stories) do
    actions =
      Enum.zip(old_stories, new_stories)
      |> Enum.map(&compare_items(&1))
      |> Enum.filter(&is_map(&1))

    {actions, new_stories}
  end

  @spec compare_items({map(), map()}) :: nil | map()
  defp compare_items({old_item, new_item}) do
    case old_item == new_item do
      true ->
        nil

      false ->
        %{action: "replace", old_item: old_item, new_item: new_item}
    end
  end

  @spec store_stories(list) :: boolean()
  defp store_stories(stories) do
    :ets.insert(:last_top_stories, {:hacker_news, stories})
  end

  @spec broadcast_update(list) :: :ok
  defp broadcast_update([]), do: :ok

  defp broadcast_update(actions) do
    HackerNewsAggregatorWeb.Endpoint.broadcast!("top_stories:lobby", "update_action", actions)
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, _pid, _reason}, state) do
    :ets.delete(:last_top_stories)
    {:noreply, state}
  end
end
