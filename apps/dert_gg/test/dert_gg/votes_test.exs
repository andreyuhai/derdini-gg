defmodule DertGG.VotesTest do
  use DertGG.DataCase, async: true

  alias DertGG.Factory
  alias DertGG.Votes

  setup do
    entry_params = %{
      author: "ssg",
      author_id: "8097",
      html_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
      text_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
      entry_id: "1",
      entry_timestamp: "15.02.1999",
      favorite_count: "13616",
      topic_url: "https://eksisozluk.com/pena--31782"
    }

    %{entry_params: entry_params}
  end

  describe "create_vote/1" do
    test "creates a vote with given account and entry_params", %{entry_params: entry_params} do
      account = Factory.insert(:account)

      params = %{
        account: account,
        entry_params: entry_params
      }

      {:ok, vote} = Votes.create_vote(params)

      assert vote.account_id == account.id
    end
  end
end
