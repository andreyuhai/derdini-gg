defmodule DertGG.PasswordResetTokens do
  alias DertGG.{
    Accounts,
    PasswordResetTokens.PasswordResetToken,
    Repo
  }

  def create_password_reset_token(email) do
    case Accounts.get_by_email(email) do
      nil ->
        {:error, :account_not_found}

      account ->
        {:ok, reset_token, _} =
          DertGG.Authentication.encode_and_sign(account, %{}, ttl: {30, :minutes})

        %PasswordResetToken{}
        |> PasswordResetToken.changeset(%{
          account: account,
          reset_token: reset_token
        })
        |> Repo.insert()
    end
  end

  def get_by_reset_token(reset_token) do
    Repo.get_by(PasswordResetToken, reset_token: reset_token)
  end

  def reset_token_used?(reset_token) do
    case get_by_reset_token(reset_token) do
      # Even if we can't find the token we still return
      # as if the token was used so the front-end will
      # display the invalid reset link error.
      nil ->
        true

      password_reset_token ->
        password_reset_token.used
    end
  end

  def update_as_used(reset_token) do
    # We assume get_by won't return nil
    get_by_reset_token(reset_token)
    |> PasswordResetToken.update_changeset(%{used: true})
    |> Repo.update!()
  end
end
