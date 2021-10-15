defmodule DertGG.Repo.Migrations.AddUniqueIndexToAccountsEmail do
  use Ecto.Migration

  def change do
    create unique_index(:accounts, [:email])
  end
end
