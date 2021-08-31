defmodule DerdiniGGWeb.SessionController do
  use DerdiniGGWeb, :controller

  def new(conn, _) do
    render(conn, :new, changeset: conn, action: "/login")
  end
end
