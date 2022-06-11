defmodule DertGG.Factory do
  use ExMachina.Ecto, repo: DertGG.Repo

  alias DertGG.Accounts.Account
  alias DertGG.Entries.Entry
  alias DertGG.PasswordResetTokens.PasswordResetToken
  alias DertGG.Votes.Vote

  def entry_factory do
    %Entry{
      author: sequence(:author, &"author#{&1}"),
      author_id: sequence(:author_id, & &1),
      html_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
      text_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
      entry_id: sequence(:entry_id, & &1),
      entry_timestamp: "16.02.2015 13:57 ~ 13:59",
      entry_created_at: ~U[2015-02-16 10:57:00Z],
      entry_updated_at: ~U[2015-02-16 10:59:00Z],
      favorite_count: :rand.uniform(10),
      topic_url: "https://eksisozluk.com/pena--31782"
    }
  end

  def account_factory do
    %Account{
      email: sequence(:email, &"foo#{&1}@bar.com"),
      encrypted_password: Argon2.hash_pwd_salt("password1")
    }
  end

  def vote_factory do
    %Vote{
      entry: build(:entry),
      account: build(:account)
    }
  end

  def entry_params_factory do
    %{
      author: "ssg",
      author_id: "8097",
      html_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
      text_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
      entry_id: "1",
      entry_timestamp: "15.02.1999",
      favorite_count: "13616",
      topic_url: "https://eksisozluk.com/pena--31782"
    }
  end

  def password_reset_token_factory(attrs) do
    account =
      Map.get_lazy(attrs, :account, fn ->
        insert(:account)
      end)

    {:ok, reset_token, _} = DertGG.Authentication.encode_and_sign(account)

    %PasswordResetToken{
      account: build(:account),
      reset_token: reset_token,
      used: false
    }
  end
end
