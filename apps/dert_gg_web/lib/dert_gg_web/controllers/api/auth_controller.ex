defmodule DertGGWeb.Api.AuthController do
  use DertGGWeb, :controller

  alias DertGG.Authentication

  def index(conn, _params) do
    with _account <- Authentication.get_current_account(conn) do
      conn
      |> json(%{})
    end
  end
end
