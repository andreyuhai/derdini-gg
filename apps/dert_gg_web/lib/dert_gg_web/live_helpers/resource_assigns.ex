defmodule DertGGWeb.LiveHelpers.ResourceAssigns do
  @moduledoc """
  Ensures current account is assigned to all LiveViews attaching this hook.
  """

  alias DertGGWeb.Authentication

  import Phoenix.LiveView

  def on_mount(:default, _params, %{"guardian_default_token" => token}, socket) do
    case Authentication.resource_from_token(token) do
      {:ok, account, claims} ->
        {:cont, assign(socket, :current_account, account)}

      _ ->
        {:halt, redirect(socket, to: "/")}
    end
  end
end
