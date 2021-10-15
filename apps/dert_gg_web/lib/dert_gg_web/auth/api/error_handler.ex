defmodule DertGGWeb.Authentication.Api.ErrorHandler do
  use DertGGWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {:unauthenticated, reason}, _opts) do
    conn
    |> json(%{
      authorized: false
    })
  end

  def auth_error(conn, {type, reason}, _opts) do
    conn
    |> json(%{
      authorized: false
    })
  end
end
