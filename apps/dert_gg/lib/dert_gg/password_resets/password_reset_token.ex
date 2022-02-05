defmodule DertGG.PasswordResetTokens.PasswordResetToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "password_reset_tokens" do
    belongs_to :account, DertGG.Accounts.Account

    field :reset_token, :string
    field :used, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  def changeset(password_reset_token, %{account: account} = attrs) do
    password_reset_token
    |> cast(attrs, [:reset_token])
    |> put_assoc(:account, account)
    |> validate_required([:reset_token, :account])
    |> unique_constraint(:reset_token)
  end

  def update_changeset(password_reset_token, attrs \\ %{}) do
    password_reset_token
    |> cast(attrs, [:used])
    |> validate_required([:used])
  end
end
