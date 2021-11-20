defmodule DertGGWeb.Api.VoteController do
  use DertGGWeb, :controller

  alias DertGGWeb.Authentication
  alias DertGG.Votes
  alias DertGG.Votes.Vote

  def create(conn, params) do
    with account <- Authentication.get_current_account(conn) do
      entry_params = prepare_params_for_entry(params)
      entry_id = Map.get(entry_params, "entry_id")

      case Votes.get_vote(account.id, entry_id) do
        %Vote{} = vote ->
          Votes.delete_vote(vote)

        nil ->
          {:ok, changes} = Votes.create_vote(%{account: account, entry_params: entry_params})
      end

      conn
      |> json(%{})
    end
  end

  defp prepare_params_for_entry(params) do
    params
    |> Map.new(fn {key, value} ->
      {String.replace(key, "-", "_"), value}
    end)
  end
end
