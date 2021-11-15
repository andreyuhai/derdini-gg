defmodule DertGGWeb.Authentication.Api.ErrorHandler do
  use DertGGWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {:unauthenticated, _reason}, _opts) do
    conn
    |> json(%{
      authenticated: false
    })
  end

  def auth_error(conn, {type, reason}, _opts) do
    conn
    |> json(%{
      error: type,
      reason: reason
    })
  end
end
