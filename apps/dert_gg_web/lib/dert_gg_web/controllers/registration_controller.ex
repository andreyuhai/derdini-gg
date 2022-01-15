defmodule DertGGWeb.RegistrationController do
  use DertGGWeb, :controller

  alias DertGG.Accounts
  alias DertGGWeb.Authentication

  def new(conn, _) do
    if Authentication.get_current_account(conn) do
      redirect(conn, to: "/")
    else
      render(conn, :new,
        changeset: Accounts.change_account(),
        action: Routes.registration_path(conn, :create)
      )
    end
  end

  def create(conn, %{"account" => account_params}) do
    case Accounts.register(account_params) do
      {:ok, account} ->
        {:ok, jwt_for_extension, _} = Authentication.encode_and_sign(account)

        conn
        |> Authentication.log_in(account)
        |> redirect(to: "/?token=#{jwt_for_extension}")

      {:error, changeset} ->
        render(conn, :new,
          changeset: changeset,
          action: Routes.registration_path(conn, :create)
        )
    end
  end
end
