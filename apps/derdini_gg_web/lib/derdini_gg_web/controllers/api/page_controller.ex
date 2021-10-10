defmodule DerdiniGGWeb.PageApiController do
  use DerdiniGGWeb, :controller

  def index(conn, _) do
    json(conn, %{foo: "bar"})
  end
end
