defmodule Ellion.Registry.Address do
  use Ellion.Schema

  import Ecto.Changeset

  alias Ellion.Geo.City
  alias Ellion.Registry.Person
  alias Ellion.Utils.Validator

  @required [:alias, :street, :zip, :city_id]

  schema "addresses" do
    field :alias, :string
    field :street, :string
    field :number, :string
    field :complement, :string
    field :neighborhood, :string
    field :zip, :string
    belongs_to :city, City
    belongs_to :person, Person

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, @required ++ [:id, :number, :complement, :neighborhood, :person_id])
    |> validate_required(@required)
    |> validate_length(:alias, max: 15)
    |> validate_length(:street, min: 2, max: 150)
    |> validate_length(:number, max: 15)
    |> validate_length(:complement, max: 100)
    |> validate_length(:neighborhood, max: 100)
    |> validate_length(:zip, min: 2, max: 15)
    |> validate_format(:zip, ~r/^[0-9]+$/, message: "must contain only numbers")
    |> update_change(:id, &Validator.cast_uuid/1)
    |> unique_constraint(:id, name: :addresses_pkey)
    |> assoc_constraint(:city)
    |> assoc_constraint(:person)
  end
end
