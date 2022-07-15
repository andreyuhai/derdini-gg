defmodule DertGGWeb.Components.Row do
  use Phoenix.Component

  def row(assigns) do
    ~H"""
    <tr class="table-hover" phx-click="show-modal" phx-value-entry-index={@entry_index}>
      <td scope="row"><%= @entry_index %></td>
      <td><div class="entry-content"><%= @entry.text_content %></div></td>
      <td><%= @vote_count %></td>
    </tr>
    """
  end
end
