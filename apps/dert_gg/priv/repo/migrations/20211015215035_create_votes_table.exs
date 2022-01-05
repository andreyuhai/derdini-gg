defmodule DertGG.Repo.Migrations.CreateVotesTable do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :entry_id, references(:entries, column: :entry_id)
      add :account_id, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:votes, [:entry_id, :account_id])
  end
end
