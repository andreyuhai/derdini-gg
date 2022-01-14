defmodule DertGGWeb.Authentication.Api.ErrorHandler do
  use DertGGWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {:unauthenticated, _reason}, _opts) do
    conn
    |> put_status(401)
    |> json(%{
      error: "unauthenticated",
    })
  end

  def auth_error(conn, {type, _reason}, _opts) do
    conn
    |> put_status(401)
    |> json(%{
      error: type
    })
  end
end
