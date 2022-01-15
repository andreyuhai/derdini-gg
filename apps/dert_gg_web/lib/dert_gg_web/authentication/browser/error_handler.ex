defmodule DertGGWeb.Authentication.Browser.ErrorHandler do
  use DertGGWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {:unauthenticated, _reason}, _opts) do
    conn
    |> put_flash(:error, "You need to be logged in.")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:error, "Something went wrong.")
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
