defmodule DerdiniGGWeb.RegistrationController do
  use DerdiniGGWeb, :controller
  alias DerdiniGG.Accounts
  alias DerdiniGGWeb.Authentication
  plug Ueberauth

  def new(conn, _) do
    render(conn, :new, changeset: conn, action: "/register")
  end

  def create(%{assigns: %{uberauth_auth: auth_params}} = conn, _params) do
    case Accounts.register(auth_params) do
      {:ok, account} ->
        redirect(conn, to: Routes.profile_path(conn, :show))

      {:error, changeset} ->
        render(conn, :new,
          changeset: changeset,
          action: Routes.registration_path(conn, :create)
        )
    end
  end
end
