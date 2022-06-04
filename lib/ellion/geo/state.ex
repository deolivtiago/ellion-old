defmodule Ellion.Geo.State do
  use Ellion.Schema

  import Ecto.Changeset

  alias Ellion.Geo.City
  alias Ellion.Geo.Country
  alias Ellion.Utils.Validator

  schema "states" do
    field :code, :string
    field :name, :string
    belongs_to :country, Country
    has_many :cities, City

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:id, :code, :name, :country_id])
    |> cast_assoc(:cities)
    |> validate_required([:code, :name])
    |> unique_constraint(:code)
    |> validate_length(:code, is: 2)
    |> update_change(:code, &String.upcase/1)
    |> validate_format(:code, ~r/^[A-Z]+$/, message: "must contain only characters A-Z")
    |> validate_length(:name, min: 2, max: 150)
    |> update_change(:id, &Validator.cast_uuid/1)
    |> unique_constraint(:id, name: :states_pkey)
    |> assoc_constraint(:country)
  end
end
