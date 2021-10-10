defmodule DerdiniGGWeb.PageController do
  use DerdiniGGWeb, :controller

  alias DerdiniGGWeb.Authentication

  def index(conn, _params) do
    with account <- Authentication.get_current_account(conn) do
      conn
      |> assign(:current_account, account)
      |> render(:index)
    end
  end
end
