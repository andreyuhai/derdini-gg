defmodule DerdiniGG.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :author, :string
      add :content, :text
      add :likes, :integer
      add :entry_id, :integer
      add :entry_timestamp, :string

      timestamps()
    end

  end
end
