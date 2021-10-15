defmodule DertGG.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :author, :string
    field :content, :string
    field :entry_id, :integer
    field :entry_timestamp, :string
    field :likes, :integer

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:author, :content, :likes, :entry_id, :entry_timestamp])
    |> validate_required([:author, :content, :likes, :entry_id, :entry_timestamp])
  end
end
