defmodule DertGGWeb.DertsLive do
  use DertGGWeb, :live_view

  alias Phoenix.PubSub

  import DertGGWeb.Components.Row

  on_mount DertGGWeb.Live.Helpers.AuthHelper

  def mount(_params, session, socket) do
    entries = DertGG.Entries.get_top_entries()
    if connected?(socket), do: PubSub.subscribe(DertGGWeb.PubSub, "vote-updates")

    {:ok, assign(socket, entries: entries, show_modal: false)}
  end

  def handle_info(%{entries: entries}, socket) do
    {:noreply, assign(socket, :entries, entries)}
  end

  def handle_event("close-modal", %{} = params, socket) do
    {:noreply, push_patch(socket, to: "/", show_modal: false)}
  end

  def handle_event("show-modal", %{} = params, socket) do
    {:noreply, push_patch(socket, to: "/#{params["entry"]}", show_modal: true)}
  end

  def handle_params(%{"entry_id" => entry_id}, uri, socket) do
    %{entry: entry} =
      Enum.find(socket.assigns.entries, &(&1.entry.id == String.to_integer(entry_id)))

    {:noreply, assign(socket, show_modal: true, entry: entry)}
  end

  def handle_params(_, _, socket) do
    {:noreply, assign(socket, show_modal: false)}
  end
end
