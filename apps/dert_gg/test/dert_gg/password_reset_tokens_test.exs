defmodule DertGG.PasswordResetTokensTest do
  use DertGG.DataCase, async: true

  alias DertGG.PasswordResetTokens
  alias DertGG.PasswordResetTokens.PasswordResetToken
  alias DertGG.Repo

  describe "create_password_reset_token/1" do
    test "creates a password reset token for an account given by its email" do
      account = DertGG.Factory.insert(:account)

      assert {:ok, %PasswordResetToken{}} =
               PasswordResetTokens.create_password_reset_token(%{"email" => account.email})
    end

    test "returns error tuple if the account doesn't exist" do
      assert {:error, :account_not_found} =
               PasswordResetTokens.create_password_reset_token(%{
                 "email" => "non-existing@email.com"
               })
    end
  end

  describe "update_as_used/1" do
    test "updates the used column of a password reset token as true" do
      password_reset_token = DertGG.Factory.insert(:password_reset_token)

      PasswordResetTokens.update_as_used(password_reset_token.reset_token)

      assert %{used: true} = Repo.reload(password_reset_token)
    end
  end
end
