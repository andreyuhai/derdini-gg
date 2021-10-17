defmodule DertGG.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :author, :string
      add :author_id, :integer
      add :content, :text
      add :entry_id, :integer
      add :entry_timestamp, :string
      add :favorite_count, :integer
      add :topic_uri, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:entries, :entry_id)
  end
end
