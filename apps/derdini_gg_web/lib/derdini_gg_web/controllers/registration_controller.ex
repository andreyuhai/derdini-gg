defmodule DerdiniGGWeb.RegistrationController do
  use DerdiniGGWeb, :controller

  plug Ueberauth

  alias DerdiniGG.Accounts
  alias DerdiniGGWeb.Authentication


  def new(conn, _) do
    render(conn, :new,
      changeset: Accounts.change_account(),
      action: Routes.registration_path(conn, :create)
    )
  end

  def create(%{assigns: %{ueberauth_auth: auth_params}} = conn, _params) do
    case Accounts.register(auth_params) do
      {:ok, account} ->
        conn
        |> Authentication.log_in(account)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        render(conn, :new,
          changeset: changeset,
          action: Routes.registration_path(conn, :create)
        )
    end
  end
end
