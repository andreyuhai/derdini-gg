defmodule DertGGWeb.SessionController do
  use DertGGWeb, :controller

  alias DertGG.Accounts
  alias DertGGWeb.Authentication

  def new(conn, _) do
    if Authentication.get_current_account(conn) do
      redirect(conn, to: Routes.page_path(conn, :index))
    else
      render(
        conn, :new,
        changeset: Accounts.change_account(),
        action: Routes.session_path(conn, :create)
      )
    end
  end

  def create(conn, %{"account" => %{"email" => email, "password" => password}}) do
    case email |> Accounts.get_by_email() |> Authentication.authenticate(password) do
      {:ok, account} ->
        {:ok, jwt_for_extension, _} =
          Authentication.encode_and_sign(account)

        conn
        |> Authentication.log_in(account)
        |> redirect(to: Routes.page_path(conn, :index, token: jwt_for_extension))

      {:error, :invalid_credentials} ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> new(%{})
    end
  end

  def delete(conn, _params) do
    conn
    |> Authentication.log_out()
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
