defmodule Ellion.Registry.Person do
  use Ellion.Schema

  import Ecto.Changeset

  alias Ellion.Registry.Address
  alias Ellion.Utils.Validator

  schema "persons" do
    field :alias, :string
    field :name, :string
    field :social_id, :string
    field :type, Ecto.Enum, values: [natural: 0, juridical: 1, other: 2]
    has_many :addresses, Address

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:id, :alias, :name, :social_id, :type])
    |> cast_assoc(:addresses)
    |> validate_required([:name, :social_id, :type])
    |> validate_length(:alias, max: 50)
    |> validate_length(:name, min: 2, max: 150)
    |> validate_length(:social_id, min: 2, max: 15)
    |> validate_format(:social_id, ~r/^[0-9]+$/, message: "must contain only numbers")
    |> update_change(:id, &Validator.cast_uuid/1)
    |> unique_constraint(:id, name: :persons_pkey)
  end
end
