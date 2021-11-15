defmodule DertGG.Votes.Vote do
  import Ecto.Changeset

  use Ecto.Schema

  schema "votes" do
    belongs_to :entry, DertGG.Entries.Entry
    belongs_to :account, DertGG.Accounts.Account

    timestamps(type: :utc_datetime)
  end

  def changeset(vote, %{account: account, entry: %DertGG.Entries.Entry{} = entry}) do
    vote
    |> change()
    |> put_assoc(:account, account)
    |> put_assoc(:entry, entry)
  end

  def changeset(vote, %{account: account, entry: _} = attrs) do
    vote
    |> cast(attrs, [])
    |> cast_assoc(:entry, with: &DertGG.Entries.change_entry/2)
    |> put_assoc(:account, account)
  end
end
