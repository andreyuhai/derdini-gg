defmodule DertGGWeb.DertsLive do
  use DertGGWeb, :live_view

  alias DertGGWeb.Authentication

  def mount(_params, session, socket) do
    entries = DertGG.Entries.get_entries()

    {
      :ok,
      socket
      |> assign(:entries, entries)
    }
  end
end
