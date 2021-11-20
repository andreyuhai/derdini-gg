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

  def upsert_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert(
      conflict_target: :entry_id,
      on_conflict: {:replace_all_except, [:id, :inserted_at]},
      returning: true
    )
  end
end
