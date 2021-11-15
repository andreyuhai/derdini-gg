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

    test "create_entry/1 with valid data creates an entry" do
      params = %{
        html_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
        text_content: "gitar calmak icin kullanilan minik plastik garip nesne.",
        entry_created_at: ~U[2021-11-15 20:37:00Z],
        entry_updated_at: ~U[2021-12-15 12:40:00Z],
        topic_url: "https://eksisozluk.com/pena--31782"
      }

      entry_params = Factory.params_for(:entry, params)

      assert {:ok, %Entry{} = entry} = Entries.create_entry(entry_params)
      assert entry.author == entry_params.author
      assert entry.author_id == entry_params.author_id
      assert entry.html_content == entry_params.html_content
      assert entry.text_content == entry_params.text_content
      assert entry.entry_id == entry_params.entry_id
      assert entry.entry_timestamp == entry_params.entry_timestamp
      assert entry.entry_created_at == entry_params.entry_created_at
      assert entry.entry_updated_at == entry_params.entry_updated_at
      assert entry.favorite_count == entry_params.favorite_count
      assert entry.topic_url == entry_params.topic_url
    end

    test "create_entry/1 with invalid data returns error changeset" do
      invalid_entry_params = Factory.params_for(:entry, author: nil)

      assert {:error, %Ecto.Changeset{}} = Entries.create_entry(invalid_entry_params)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = Factory.insert(:entry)

      entry_update_params = %{
        html_content: "Changed html content",
        text_content: "Changed text content",
        favorite_count: 123
      }

      assert {:ok, %Entry{} = entry} = Entries.update_entry(entry, entry_update_params)
      assert entry.html_content == entry_update_params.html_content
      assert entry.text_content == entry_update_params.text_content
      assert entry.favorite_count == entry_update_params.favorite_count
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = Factory.insert(:entry)
      invalid_entry_params = %{entry_id: nil}

      assert {:error, %Ecto.Changeset{}} = Entries.update_entry(entry, invalid_entry_params)
      assert Entries.get_entry!(entry.id) == entry
    end

    test "delete_entry/1 deletes the entry" do
      entry = Factory.insert(:entry)

      assert {:ok, %Entry{}} = Entries.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_entry!(entry.id) end
    end

    test "change_entry/1 returns an entry changeset" do
      entry = Factory.insert(:entry)

      assert %Ecto.Changeset{} = Entries.change_entry(entry)
    end
  end
end
