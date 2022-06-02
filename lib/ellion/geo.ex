defmodule Ellion.Geo do
  @moduledoc """
  Geolocation context.
  """

  import Ecto.Query, warn: false

  alias Ellion.Geo.Country
  alias Ellion.Repo

  @doc """
  Returns the list of countries.

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  def list_countries, do: Repo.all(Country)

  @doc """
  Gets a single country.

  ## Examples

      iex> get_country(valid_uuid)
      {:ok, %Country{}}

      iex> get_country(invalid_uuid)
      {:error, %Ecto.Changeset{}}

  """
  def get_country(id) do
    country = Repo.get!(Country, id)

    {:ok, country}
  rescue
    Ecto.NoResultsError ->
      {:error, Country.error_changeset(:id, id, "not found")}

    Ecto.Query.CastError ->
      {:error, Country.error_changeset(:id, id, "invalid uuid")}
  end

  @doc """
  Creates a country.

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country(attrs \\ %{}) do
    %Country{}
    |> Country.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a country.

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country(%Country{} = country, attrs) do
    country
    |> Country.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a country.

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country(%Country{} = country) do
    Repo.delete(country)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country changes.

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{data: %Country{}}

  """
  def change_country(%Country{} = country, attrs \\ %{}) do
    Country.changeset(country, attrs)
  end
end
