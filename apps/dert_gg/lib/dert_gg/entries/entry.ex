defmodule DertGG.Entries.Entry do
  import Ecto.Changeset

  use Ecto.Schema

  schema "entries" do
    field :author, :string
    field :author_id, :integer
    field :content, :string
    field :entry_id, :integer
    field :entry_timestamp, :string
    field :favorite_count, :integer
    field :topic_uri, :string

    has_many :votes, DertGG.Votes.Vote

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [
      :author,
      :author_id,
      :content,
      :entry_id,
      :entry_timestamp,
      :favorite_count,
      :topic_uri
    ])
    |> validate_required([
      :author,
      :author_id,
      :content,
      :entry_id,
      :entry_timestamp,
      :favorite_count,
      :topic_uri
    ])
    |> unique_constraint(:entry_id)
  end
end
