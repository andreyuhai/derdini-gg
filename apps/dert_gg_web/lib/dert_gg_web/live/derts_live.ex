defmodule DertGGWeb.DertsLive do
  use DertGGWeb, :live_view

  alias DertGGWeb.Authentication

  on_mount({DertGGWeb.LiveHelpers.ResourceAssigns, :default})

  def render(assigns) do
    ~H"""
    <table>
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col">Entry</th>
          <th scope="col">By</th>
          <th scope="col">GG Count</th>
        </tr>
      </thead>
      <tbody>
        <%= for {entry, index} <- Enum.with_index(@entries, 1) do %>
          <tr>
            <th scope="row"><%= index %></th>
            <td><a href={"https://eksisozluk.com/entry/#{entry.entry_id}"}>Entry link</a></td>
            <td><%= entry.author %></td>
            <td><%= IO.inspect(length(entry.votes)) %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

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
