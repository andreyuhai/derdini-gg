defmodule DertGGWeb.Api.VoteController do
  use DertGGWeb, :controller

  alias DertGGWeb.Authentication

  def upvote(conn, _params) do
    with _account <- Authentication.get_current_account(conn) do
      conn
      |> json(%{})
    end
  end
end
