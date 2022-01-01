defmodule DertGG.Entries do
  @moduledoc """
  The Entries context.
  """

  import Ecto.Query, warn: false
  alias DertGG.Repo

  alias DertGG.Entries.Entry

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id)

  def get_entries(), do: Repo.all(from e in Entry, preload: [:votes])

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(%{entry_timestamp: entry_timestamp} = attrs) do
    entry_created_at = entry_created_at_from_timestamp(entry_timestamp)
    entry_updated_at = entry_updated_at_from_timestamp(entry_timestamp)

    attrs =
      Map.merge(attrs, %{entry_created_at: entry_created_at, entry_updated_at: entry_updated_at})

    %Entry{}
    |> change_entry(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{data: %Entry{}}

  """
  def change_entry(%Entry{} = entry, attrs \\ %{}) do
    Entry.changeset(entry, attrs)
  end

  def upsert_entry(%{entry_timestamp: entry_timestamp} = attrs) do
    entry_created_at = entry_created_at_from_timestamp(entry_timestamp)
    entry_updated_at = entry_updated_at_from_timestamp(entry_timestamp)

    attrs =
      Map.merge(attrs, %{
        entry_created_at: entry_created_at,
        entry_updated_at: entry_updated_at
      })

    %Entry{}
    |> change_entry(attrs)
    |> Repo.insert(
      conflict_target: :entry_id,
      on_conflict: {:replace_all_except, [:id, :inserted_at]},
      returning: true
    )
  end

  defp entry_created_at_from_timestamp(entry_timestamp) do
    ~r/^(?<date>(?<day>\d{2})\.(?<month>\d{2})\.(?<year>\d{4}))\s*(?<time>(?<hour>\d{2}):(?<minute>\d{2}))?/
    |> Regex.named_captures(entry_timestamp)
    |> datetime_from_map()
  end

  defp entry_updated_at_from_timestamp(entry_timestamp) do
    entry_created_at = entry_created_at_from_timestamp(entry_timestamp)

    ~r/~{1}\s+(?<date>(?<day>\d{2})\.(?<month>\d{2})\.(?<year>\d{4}))?\s*(?<time>(?<hour>\d{2}):(?<minute>\d{2}))/
    |> Regex.named_captures(entry_timestamp)
    # Check whether the entry was updated on the same date
    |> case do
      %{"date" => ""} = entry_updated_at_map ->
        %{
          entry_updated_at_map
          | "day" => entry_created_at.day |> to_string() |> String.pad_leading(2, "0"),
            "month" => entry_created_at.month |> to_string() |> String.pad_leading(2, "0"),
            "year" => entry_created_at.year
        }

      map ->
        map
    end
    |> datetime_from_map()
  end

  defp datetime_from_map(nil), do: nil

  defp datetime_from_map(%{
         "day" => day,
         "month" => month,
         "year" => year,
         "hour" => "",
         "minute" => ""
       }) do
    # Passing the hour as 03:00 because Turkey's time is UTC+03:00 so unknown hours will be 00:00
    datetime_from_map(%{
      "day" => day,
      "month" => month,
      "year" => year,
      "hour" => "03",
      "minute" => "00"
    })
  end

  defp datetime_from_map(%{
         "day" => day,
         "month" => month,
         "year" => year,
         "hour" => hour,
         "minute" => minute
       }) do
    # +03:00 added at the end because Turkey's time is UTC+03:00
    {:ok, datetime, _} =
      DateTime.from_iso8601("#{year}-#{month}-#{day} #{hour}:#{minute}:00+03:00")

    datetime
  end
end
