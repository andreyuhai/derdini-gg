defmodule DertGGWeb.LiveComponent.ModalComponent do
  use DertGGWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="modal fade show" style="display: block;" tabindex="-1" phx-click="close-modal">
      <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content" phx-click="">
          <div class="modal-header">
            <h5 class="modal-title">Entry</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" phx-click="close-modal"></button>
          </div>
          <div class="modal-body">
            <%= @entry.text_content %>
          </div>
          <div class="modal-footer">
            <a href={"https://eksisozluk.com/entry/#{@entry.entry_id}"} target="_blank"><%= @entry.author %></a>
            <p><%= @entry.entry_created_at %></p>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
