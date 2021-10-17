defmodule DertGG.EntriesTest do
  use DertGG.DataCase, async: true

  alias DertGG.Entries
  alias DertGG.Factory

  describe "entries" do
    alias DertGG.Entries.Entry

    test "list_entries/0 returns all entries" do
      entry = Factory.insert(:entry)
      assert Entries.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = Factory.insert(:entry)
      assert Entries.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      entry_params = Factory.params_for(:entry)

      assert {:ok, %Entry{} = entry} = Entries.create_entry(entry_params)
      assert entry.author == entry_params.author
      assert entry.content == entry_params.content
      assert entry.entry_id == entry_params.entry_id
      assert entry.entry_timestamp == entry_params.entry_timestamp
      assert entry.favorite_count == entry_params.favorite_count
    end

    test "create_entry/1 with invalid data returns error changeset" do
      invalid_entry_params = Factory.params_for(:entry, author: nil)

      assert {:error, %Ecto.Changeset{}} = Entries.create_entry(invalid_entry_params)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = Factory.insert(:entry)
      entry_update_params = Factory.params_for(:entry)

      assert {:ok, %Entry{} = entry} = Entries.update_entry(entry, entry_update_params)
      assert entry.author == entry_update_params.author
      assert entry.content == entry_update_params.content
      assert entry.entry_id == entry_update_params.entry_id
      assert entry.entry_timestamp == entry_update_params.entry_timestamp
      assert entry.favorite_count == entry_update_params.favorite_count
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = Factory.insert(:entry)
      invalid_entry_params = %{entry_id: nil}

      assert {:error, %Ecto.Changeset{}} = Entries.update_entry(entry, invalid_entry_params)
      assert entry == Entries.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = Factory.insert(:entry)

      assert {:ok, %Entry{}} = Entries.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = Factory.insert(:entry)
      assert %Ecto.Changeset{} = Entries.change_entry(entry)
    end
  end
end
