defmodule DertGG.EntriesTest do
  use DertGG.DataCase

  alias DertGG.Entries

  describe "entries" do
    alias DertGG.Entries.Entry

    @valid_attrs %{author: "some author", content: "some content", entry_id: 42, entry_timestamp: "some entry_timestamp", likes: 42}
    @update_attrs %{author: "some updated author", content: "some updated content", entry_id: 43, entry_timestamp: "some updated entry_timestamp", likes: 43}
    @invalid_attrs %{author: nil, content: nil, entry_id: nil, entry_timestamp: nil, likes: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entries.create_entry()

      entry
    end

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Entries.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Entries.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Entries.create_entry(@valid_attrs)
      assert entry.author == "some author"
      assert entry.content == "some content"
      assert entry.entry_id == 42
      assert entry.entry_timestamp == "some entry_timestamp"
      assert entry.likes == 42
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entries.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{} = entry} = Entries.update_entry(entry, @update_attrs)
      assert entry.author == "some updated author"
      assert entry.content == "some updated content"
      assert entry.entry_id == 43
      assert entry.entry_timestamp == "some updated entry_timestamp"
      assert entry.likes == 43
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Entries.update_entry(entry, @invalid_attrs)
      assert entry == Entries.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Entries.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Entries.change_entry(entry)
    end
  end
end
