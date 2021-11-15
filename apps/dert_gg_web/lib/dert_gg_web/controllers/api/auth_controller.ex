defmodule DertGGWeb.Api.AuthController do
  use DertGGWeb, :controller

  alias DertGGWeb.Authentication

  def index(conn, _params) do
    with account <- Authentication.get_current_account(conn) do
      conn
      |> json(%{})
    end
  end
end
