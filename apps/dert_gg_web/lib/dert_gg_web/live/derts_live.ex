defmodule DertGGWeb.DertsLive do
  use DertGGWeb, :live_view

  alias Phoenix.PubSub

  import DertGGWeb.Components.Row

  on_mount DertGGWeb.Live.Helpers.AuthHelper

  def mount(_params, _session, socket) do
    entries = DertGG.Entries.get_top_entries()
    if connected?(socket), do: PubSub.subscribe(DertGGWeb.PubSub, "vote-updates")

    {:ok, assign(socket, entries: entries, show_modal: false)}
  end

  def handle_info(%{entries: entries}, socket) do
    {:noreply, assign(socket, :entries, entries)}
  end

  def handle_event("close-modal", %{} = _params, socket) do
    {:noreply, push_patch(socket, to: "/", show_modal: false)}
  end

  def handle_event("show-modal", %{} = params, socket) do
    {:noreply, push_patch(socket, to: "/#{params["entry"]}", show_modal: true)}
  end

  def handle_params(%{"entry_id" => entry_id}, _uri, socket) do
    with {entry_id, _binary} <- Integer.parse(entry_id),
         {:ok, entry} <- find_entry(socket.assigns.entries, entry_id) do
      {:noreply, assign(socket, show_modal: true, entry: entry)}
    else
      _ -> {:noreply, socket}
    end
  end

  def handle_params(_, _, socket) do
    {:noreply, assign(socket, show_modal: false)}
  end

  # TODO: Fix this mess, use virtual field maybe for vote_count within entry
  @type entry :: %{entry: map(), vote_count: number()}
  @spec find_entry([entry], entry_id :: number()) ::
          {:ok, map()} | {:error, :entry_not_found}
  defp find_entry(entries, entry_id) do
    case Enum.find(entries, &(&1.entry.id == entry_id)) do
      nil -> {:error, :entry_not_found}
      entry -> {:ok, entry.entry}
    end
  end
end
