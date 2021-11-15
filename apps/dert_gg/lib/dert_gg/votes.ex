defmodule DertGG.Votes do
  @moduledoc """
  The Votes context.
  """

  import Ecto.Query, warn: false

  alias DertGG.Entries
  alias DertGG.Repo
  alias DertGG.Votes.Vote
  alias Ecto.Multi

  def create_vote(%{account: account, entry: entry}) do
    Multi.new()
    |> Multi.run(:entry, fn _repo, _changes ->
      Entries.upsert_entry(entry)
    end)
    |> Multi.insert(:vote, fn %{entry: entry} ->
      change_vote(%Vote{}, %{account: account, entry: entry})
    end)
    |> Repo.transaction()
  end

  def change_vote(%Vote{} = vote, attrs \\ %{}) do
    Vote.changeset(vote, attrs)
  end
end
