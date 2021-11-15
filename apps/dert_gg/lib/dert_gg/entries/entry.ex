defmodule DertGG.Entries.Entry do
  import Ecto.Changeset

  use Ecto.Schema

  schema "entries" do
    field :author, :string
    field :author_id, :integer
    field :html_content, :string
    field :text_content, :string
    field :entry_id, :integer
    field :entry_timestamp, :string
    field :entry_created_at, :utc_datetime
    field :entry_updated_at, :utc_datetime
    field :favorite_count, :integer
    field :topic_url, :string

    has_many :votes, DertGG.Votes.Vote

    timestamps(type: :utc_datetime)
  end

  @fields [
    :author, :author_id, :html_content, :text_content,
    :entry_id, :entry_timestamp, :entry_created_at,
    :entry_updated_at, :favorite_count, :topic_url
  ]

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:entry_id)
  end
end
