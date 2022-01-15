defmodule DertGGWeb.DertsLive do
  use DertGGWeb, :live_view

  alias DertGGWeb.Authentication

  def mount(_params, session, socket) do
    IO.inspect(session, label: "HERE IS THE SESSION")
    IO.inspect(socket, label: "HERE IS THE SOCKET")

    with account <- Authentication.get_current_account(socket) do
      entries = DertGG.Entries.get_entries()
      if connected?(socket), do: Process.send_after(self(), :update, 1000)

      {
        :ok,
        socket
        |> assign(:current_account, account)
        |> assign(:entries, entries)
      }
    end
  end

  def handle_info(:update, socket) do
    entries = DertGG.Entries.get_entries()
    {:noreply, assign(socket, entries: entries)}
  end
end
