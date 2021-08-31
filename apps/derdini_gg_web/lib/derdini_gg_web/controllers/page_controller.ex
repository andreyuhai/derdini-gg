defmodule DerdiniGGWeb.PageController do
  use DerdiniGGWeb, :controller
  alias DerdiniGGWeb.Authentication

  def index(conn, _params) do
    current_account = Authentication.get_current_account(conn)
    render(conn, :index, current_account: current_account)
  end
end
