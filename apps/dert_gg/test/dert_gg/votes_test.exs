defmodule DertGG.VotesTest do
  use DertGG.DataCase, async: true

  alias DertGG.Factory
  alias DertGG.Votes

  describe "create_vote/1" do
    test "creates a vote with given account and entry_params" do
      account = Factory.insert(:account)

      params = %{
        account: account,
        entry_params: Factory.build(:entry_params)
      }

      {:ok, vote} = Votes.create_vote(params)

      assert vote.account_id == account.id
    end
  end
end
