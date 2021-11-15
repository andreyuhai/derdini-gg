defmodule DertGG.Factory do
  use ExMachina.Ecto, repo: DertGG.Repo

  alias DertGG.Accounts.Account
  alias DertGG.Entries.Entry
  alias DertGG.Votes.Vote

  def entry_factory do
    %Entry{
      author: sequence(:author, &"author#{&1}"),
      author_id: sequence(:author_id, & &1),
      html_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
      text_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
      entry_id: sequence(:entry_id, & &1),
      entry_timestamp: "16.02.2015 13:57 ~ 13:59",
      entry_created_at: DateTime.utc_now(),
      entry_updated_at: DateTime.utc_now(),
      favorite_count: :rand.uniform(10),
      topic_url: "https://eksisozluk.com/wi-fi-sifresini-isteyen-komsuyu-savusturma-yollari--4692875"
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
end
