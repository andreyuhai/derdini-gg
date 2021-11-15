defmodule DertGG.VotesTest do
  use DertGG.DataCase, async: true

  alias DertGG.Factory
  alias DertGG.Votes

  test "create_vote/1" do
    account = Factory.insert(:account)
    entry_params = Factory.params_for(:entry)

    params = %{
      entry: entry_params,
      account: account
    }

    {:ok, %{vote: vote}} = Votes.create_vote(params)

    assert vote.account_id == account.id
  end
end
