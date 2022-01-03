defmodule DertGGWeb.PageController do
  use DertGGWeb, :controller

  alias DertGGWeb.Authentication

  def index(conn, _params) do
    with account <- Authentication.get_current_account(conn) do
      entries = DertGG.Entries.get_entries()

      conn
      |> assign(:current_account, account)
      |> render(:index, entries: entries)
    end
  end
end
