defmodule DertGG.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :email, :string
      add :encrypted_password, :string

      timestamps(type: :utc_datetime)
    end

  end
end
