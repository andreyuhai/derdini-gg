defmodule DertGG.Votes.Vote do
  import Ecto.Changeset

  use Ecto.Schema

  schema "votes" do
    belongs_to :entry, DertGG.Entries.Entry, foreign_key: :entry_id, references: :entry_id
    belongs_to :account, DertGG.Accounts.Account

    timestamps(type: :utc_datetime)
  end

  def changeset(vote, %{account: account, entry: %DertGG.Entries.Entry{} = entry}) do
    vote
    |> change()
    |> put_assoc(:account, account)
    |> put_assoc(:entry, entry)
    |> assoc_constraint(:entry)
    |> unique_constraint([:entry_id, :account_id])
  end
end
