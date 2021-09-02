defmodule DerdiniGGWeb.RegistrationController do
  use DerdiniGGWeb, :controller

  alias DerdiniGG.Accounts
  alias DerdiniGGWeb.Authentication

  def new(conn, _) do
    render(conn, :new,
      changeset: Accounts.change_account(),
      action: Routes.registration_path(conn, :create)
    )
  end

  def create(conn, %{"account" => account_params}) do
    case Accounts.register(account_params) do
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
