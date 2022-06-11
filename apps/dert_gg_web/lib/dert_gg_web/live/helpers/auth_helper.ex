defmodule DertGGWeb.Live.Helpers.AuthHelper do
  @moduledoc false

  import Phoenix.LiveView

  def on_mount(:default, _params, %{"guardian_default_token" => token}, socket) do
    {:ok, account, _claims} = DertGG.Authentication.resource_from_token(token)

    {:cont, assign(socket, :current_account, account)}
  end

  def on_mount(:default, _params, _session, socket) do
    {:cont, socket}
  end
end
