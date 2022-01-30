defmodule DertGGWeb.PasswordResetController do
  use DertGGWeb, :controller

  alias DertGG.Accounts
  alias DertGG.PasswordResetTokens
  alias DertGGWeb.Authentication

  def new(conn, %{}) do
    render(conn, :new, action: Routes.password_reset_path(conn, :create))
  end

  def create(conn, params) do
    case PasswordResetTokens.create_password_reset_token(params) do
      {:ok, reset_token} ->
        # Here send the email
        IO.inspect(reset_token)

      {:error, _} ->
        # Here do nothing
        :ok
    end

    conn
    |> put_flash(
      :info,
      "If an account with given email exists, a password reset email will be sent shortly."
    )
    |> redirect(to: Routes.password_reset_path(conn, :new))
  end

  def edit(conn, %{"id" => reset_token}) do
    with {:ok, account, _} <- Authentication.resource_from_token(reset_token),
         false <- PasswordResetTokens.reset_token_used?(reset_token) do
      render(conn, :edit,
        action: Routes.password_reset_path(conn, :update, reset_token),
        password_reset_changeset: Accounts.change_password(account)
      )
    else
      _ ->
        conn
        |> put_flash(:error, "Invalid password reset link.")
        |> redirect(to: Routes.password_reset_path(conn, :new))
    end
  end

  def update(conn, %{"id" => reset_token, "password_reset_params" => password_reset_params}) do
    with {:ok, account, _} <- Authentication.resource_from_token(reset_token),
         false <- PasswordResetTokens.reset_token_used?(reset_token) do
      case Accounts.update_password(account, password_reset_params) do
        {:ok, _account} ->
          PasswordResetTokens.update_as_used(reset_token)

          conn
          |> put_flash(:info, "Your password has been successfully updated.")
          |> redirect(to: Routes.session_path(conn, :new))

        {:error, changeset} ->
          render(conn, :edit,
            password_reset_changeset: changeset,
            action: Routes.password_reset_path(conn, :update, reset_token)
          )
      end
    else
      _ ->
        conn
        |> put_flash(:error, "Invalid password reset link.")
        |> redirect(to: Routes.password_reset_path(conn, :new))
    end
  end
end
