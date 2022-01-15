defmodule DertGGWeb.DertsLive do
  use DertGGWeb, :live_view

  def mount(_params, _session, socket) do
    entries = DertGG.Entries.get_entries()

    {
      :ok,
      socket
      |> assign(:entries, entries)
    }
  end
end
