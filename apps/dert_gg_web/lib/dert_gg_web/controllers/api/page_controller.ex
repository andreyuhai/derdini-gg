defmodule DertGGWeb.Api.PageController do
  use DertGGWeb, :controller

  def index(conn, _) do
    json(conn, %{foo: "bar"})
  end
end
