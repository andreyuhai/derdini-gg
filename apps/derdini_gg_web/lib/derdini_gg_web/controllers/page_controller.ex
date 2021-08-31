defmodule DerdiniGGWeb.PageController do
  use DerdiniGGWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
