defmodule Ellion.Geo.Country do
  use Ellion.Schema

  import Ecto.Changeset

  alias Ellion.Geo.State
  alias Ellion.Utils.Validator

  schema "countries" do
    field :code, :string
    field :name, :string
    has_many :states, State

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:id, :code, :name])
    |> cast_assoc(:states)
    |> validate_required([:code, :name])
    |> unique_constraint(:code)
    |> validate_length(:code, is: 2)
    |> update_change(:code, &String.upcase/1)
    |> validate_format(:code, ~r/^[A-Z]+$/, message: "must contain only characters A-Z")
    |> validate_length(:name, min: 2, max: 150)
    |> update_change(:id, &Validator.cast_uuid/1)
    |> unique_constraint(:id, name: :countries_pkey)
  end
end
