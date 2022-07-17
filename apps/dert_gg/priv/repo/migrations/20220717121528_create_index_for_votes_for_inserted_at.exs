defmodule DertGG.Repo.Migrations.CreateIndexForVotesForInsertedAt do
  use Ecto.Migration

  def change do
    create index(:votes, ["date(inserted_at)"])
  end
end
