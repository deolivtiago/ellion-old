defmodule Ellion.Registry do
  @moduledoc """
  Registry context.
  """

  alias Ellion.Registry.Address
  alias Ellion.Registry.Person
  alias Ellion.Repo

  @doc """
  Returns the list of persons.

  ## Examples

      iex> list_persons()
      [%Person{}, ...]

  """
  def list_persons, do: Repo.all(Person)

  @doc """
  Gets a single person.

  ## Examples

      iex> get_person!(valid_uuid)
      {:ok, %Person{}}

      iex> get_person!(invalid_uuid)
      {:error, %Ecto.Changeset{}}

  """
  def get_person(id) do
    person = Repo.get!(Person, id)

    {:ok, person}
  rescue
    Ecto.NoResultsError ->
      {:error, Person.error_changeset(:id, id, "not found [person]")}

    Ecto.Query.CastError ->
      {:error, Person.error_changeset(:id, id, "invalid format [person]")}
  end

  @doc """
  Creates a person.

  ## Examples

      iex> create_person(%{field: value})
      {:ok, %Person{}}

      iex> create_person(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_person(attrs \\ %{}) do
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a person.

  ## Examples

      iex> update_person(person, %{field: new_value})
      {:ok, %Person{}}

      iex> update_person(person, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_person(%Person{} = person, attrs) do
    person
    |> Person.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a person.

  ## Examples

      iex> delete_person(person)
      {:ok, %Person{}}

      iex> delete_person(person)
      {:error, %Ecto.Changeset{}}

  """
  def delete_person(%Person{} = person) do
    Repo.delete(person)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking person changes.

  ## Examples

      iex> change_person(person)
      %Ecto.Changeset{data: %Person{}}

  """
  def change_person(%Person{} = person, attrs \\ %{}) do
    Person.changeset(person, attrs)
  end

  @doc """
  Returns the list of addresses.

  ## Examples

      iex> list_addresses()
      [%Address{}, ...]

  """
  def list_addresses, do: Repo.all(Address)

  @doc """
  Gets a single address.

  ## Examples

      iex> get_address(valid_uuid)
      {:ok, %Address{}}

      iex> get_address(invalid_uuid)
      {:error, %Ecto.Changeset{}}

  """
  def get_address(id) do
    address = Repo.get!(Address, id)

    {:ok, address}
  rescue
    Ecto.NoResultsError ->
      {:error, Address.error_changeset(:id, id, "not found [address]")}

    Ecto.Query.CastError ->
      {:error, Address.error_changeset(:id, id, "invalid format [address]")}
  end

  @doc """
  Creates a address.

  ## Examples

      iex> create_address(%{field: value})
      {:ok, %Address{}}

      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_address(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a address.

  ## Examples

      iex> update_address(address, %{field: new_value})
      {:ok, %Address{}}

      iex> update_address(address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_address(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a address.

  ## Examples

      iex> delete_address(address)
      {:ok, %Address{}}

      iex> delete_address(address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_address(%Address{} = address) do
    Repo.delete(address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking address changes.

  ## Examples

      iex> change_address(address)
      %Ecto.Changeset{data: %Address{}}

  """
  def change_address(%Address{} = address, attrs \\ %{}) do
    Address.changeset(address, attrs)
  end
end
