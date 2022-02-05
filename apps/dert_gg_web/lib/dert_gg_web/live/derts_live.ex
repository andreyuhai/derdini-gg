defmodule DertGGWeb.DertsLive do
  use DertGGWeb, :live_view

  alias Phoenix.PubSub

  on_mount DertGGWeb.Live.Helpers.AuthHelper

  def mount(_params, session, socket) do
    entries = DertGG.Entries.get_top_entries()
    if connected?(socket), do: PubSub.subscribe(DertGGWeb.PubSub, "vote-updates")

    {:ok, assign(socket, entries: entries)}
  end

  def handle_info(%{entries: entries}, socket) do
    {:noreply, assign(socket, :entries, entries)}
  end
end
