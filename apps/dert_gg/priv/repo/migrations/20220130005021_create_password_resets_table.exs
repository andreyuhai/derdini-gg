defmodule DertGG.Repo.Migrations.CreatePasswordResetsTable do
  use Ecto.Migration

  def change do
    create table(:password_reset_tokens) do
      add :account_id, references(:accounts)
      add :reset_token, :text
      add :used, :boolean, default: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:password_reset_tokens, :reset_token)
  end
end
