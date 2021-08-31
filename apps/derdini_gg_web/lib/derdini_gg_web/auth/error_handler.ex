defmodule DerdiniGGWeb.Authentication.ErrorHandler do
  use DerdiniGGWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {:unauthenticated, reason}, _opts) do
    conn
    |> put_flash(:error, "You need to be logged in.")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  def auth_error(conn, {type, reason}, _opts) do
    conn
    |> put_flash(:error, "Something went wrong.")
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
