defmodule DertGG.EntriesTest do
  use DertGG.DataCase, async: true

  alias DertGG.Entries
  alias DertGG.Entries.Entry
  alias DertGG.Factory

  @possible_entry_timestamps %{
    "15.02.1999" => [entry_created_at: ~U[1999-02-15 00:00:00Z], entry_updated_at: nil],
    "17.12.1999 12:35" => [entry_created_at: ~U[1999-12-17 09:35:00Z], entry_updated_at: nil],
    "13.06.2001 21:35 ~ 14.09.2009 22:29" => [
      entry_created_at: ~U[2001-06-13 18:35:00Z],
      entry_updated_at: ~U[2009-09-14 19:29:00Z]
    ],
    "30.07.2002 09:47 ~ 09:50" => [
      entry_created_at: ~U[2002-07-30 06:47:00Z],
      entry_updated_at: ~U[2002-07-30 06:50:00Z]
    ]
  }

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

  describe "create_entry/1" do
    for {entry_timestamp,
         [entry_created_at: entry_created_at, entry_updated_at: entry_updated_at]} <-
          @possible_entry_timestamps do
      test "creates entry with entry timestamp #{entry_timestamp}", %{
        entry_params: entry_params
      } do
        entry_params = %{entry_params | entry_timestamp: unquote(entry_timestamp)}

        assert {:ok, %Entry{} = entry} = Entries.create_entry(entry_params)

        assert entry.entry_created_at == unquote(Macro.escape(entry_created_at)),
               "With given entry_timestamp #{entry_params.entry_timestamp} got entry_created_at as #{entry.entry_created_at}"

        assert entry.entry_updated_at == unquote(Macro.escape(entry_updated_at)),
               "With given entry_timestamp #{entry_params.entry_timestamp} got entry_updated_at as #{entry.entry_updated_at}"
      end
    end

    test "create_entry/1 with invalid data returns error changeset" do
      invalid_entry_params = Factory.params_for(:entry, author: nil)

      assert {:error, %Ecto.Changeset{}} = Entries.create_entry(invalid_entry_params)
    end
  end

  test "change_entry/1 returns an entry changeset" do
    entry = Factory.insert(:entry)

    assert %Ecto.Changeset{} = Entries.change_entry(entry)
  end

  describe "upsert_entry/1" do
    test "upserts entries with different entry timestamps", %{entry_params: entry_params} do
      for {entry_timestamp,
           [entry_created_at: entry_created_at, entry_updated_at: entry_updated_at]} <-
            @possible_entry_timestamps do
        entry_params = %{entry_params | entry_timestamp: entry_timestamp}

        assert {:ok, %Entry{} = entry} = Entries.upsert_entry(entry_params)

        assert entry.entry_created_at == entry_created_at,
               "With given entry_timestamp #{entry_params.entry_timestamp} got entry_created_at as #{entry.entry_created_at}"

        assert entry.entry_updated_at == entry_updated_at,
               "With given entry_timestamp #{entry_params.entry_timestamp} got entry_updated_at as #{entry.entry_updated_at}"
      end
    end
  end
end
