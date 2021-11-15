defmodule DertGG.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :author, :string
      add :author_id, :integer
      add :html_content, :text
      add :text_content, :text
      add :entry_id, :integer
      add :entry_timestamp, :string
      add :entry_created_at, :utc_datetime
      add :entry_updated_at, :utc_datetime
      add :favorite_count, :integer
      add :topic_url, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:entries, :entry_id)
  end
end
