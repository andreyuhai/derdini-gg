defmodule DertGGWeb.Api.AuthController do
  use DertGGWeb, :controller

  def index(conn, _params) do
    json(conn, %{})
  end
end
