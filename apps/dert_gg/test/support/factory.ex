defmodule DertGG.Factory do
  use ExMachina.Ecto, repo: DertGG.Repo

  alias DertGG.Accounts.Account
  alias DertGG.Entries.Entry
  alias DertGG.Votes.Vote

  def entry_factory(attrs \\ %{}) do
    %Entry{
      author: sequence(:author, &"author#{&1}"),
      author_id: sequence(:author_id, & &1),
      content: "Some entry content",
      entry_id: sequence(:entry_id, & &1),
      entry_timestamp: "16.02.2015 13:57 ~ 13:59",
      favorite_count: :rand.uniform(10),
      topic_uri: "https://eksisozluk.com/wi-fi-sifresini-isteyen-komsuyu-savusturma-yollari--4692875"
    }
    |> merge_attributes(attrs)
  end

  def account_factory(attrs \\ %{}) do
    %Account{
      email: sequence(:email, &"foo#{&1}@bar.com"),
      encrypted_password: Argon2.hash_pwd_salt("password1")
    }
    |> merge_attributes(attrs)
  end

  def vote_factory(attrs \\ %{}) do
    %Vote{
      entry: build(:entry),
      account: build(:account)
    }
    |> merge_attributes(attrs)
  end
end
