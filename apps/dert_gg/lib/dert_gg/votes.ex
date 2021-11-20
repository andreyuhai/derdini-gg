defmodule DertGG.Votes do
  @moduledoc """
  The Votes context.
  """

  import Ecto.Query, warn: false

  alias DertGG.Entries
  alias DertGG.Repo
  alias DertGG.Votes.Vote

  def create_vote(%{account: account, entry_params: entry_params}) do
    Repo.transaction(fn ->
      {:ok, entry} = Entries.upsert_entry(entry_params)

      {:ok, vote} =
        %Vote{}
        |> change_vote(%{account: account, entry: entry})
        |> Repo.insert()

      vote
    end)
  end

  def change_vote(%Vote{} = vote, attrs \\ %{}) do
    Vote.changeset(vote, attrs)
  end

  def get_vote(account_id, entry_id) do
    Repo.get_by(Vote, account_id: account_id, entry_id: entry_id)
  end

  def delete_vote(vote) do
    Repo.delete(vote)
  end
end
