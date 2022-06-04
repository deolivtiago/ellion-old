defmodule Ellion.Geo.City do
  use Ellion.Schema

  import Ecto.Changeset

  alias Ellion.Geo.State
  alias Ellion.Registry.Address
  alias Ellion.Utils.Validator

  schema "cities" do
    field :name, :string
    belongs_to :state, State
    has_many :addresses, Address

    timestamps()
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:id, :name, :state_id])
    |> validate_required([:name])
    |> validate_length(:name, min: 2, max: 150)
    |> update_change(:id, &Validator.cast_uuid/1)
    |> unique_constraint(:id, name: :cities_pkey)
    |> assoc_constraint(:state)
  end
end
