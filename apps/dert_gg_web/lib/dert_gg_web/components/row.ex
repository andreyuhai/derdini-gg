defmodule DertGGWeb.Components.Row do
  use Phoenix.Component

  def row(assigns) do
    ~H"""
    <tr class="table-hover" phx-click="show-modal" phx-value-entry={@entry.id}>
      <td scope="row"><%= @num %></td>
      <td><div class="entry-content"><%= @entry.text_content %></div></td>
      <td><a href={"https://eksisozluk.com/entry/#{@entry.entry_id}"}><%= @entry.author %></a></td>
      <td><%= @vote_count %></td>
    </tr>
    """
  end
end
