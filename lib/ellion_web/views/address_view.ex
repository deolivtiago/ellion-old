defmodule EllionWeb.AddressView do
  use EllionWeb, :view

  alias EllionWeb.AddressView

  @doc """
  Renders a list of addresses.
  """
  def render("index.json", %{addresses: addresses}) do
    %{data: render_many(addresses, AddressView, "address.json"), success: true}
  end

  @doc """
  Renders a single address.
  """
  def render("show.json", %{address: address}) do
    %{data: render_one(address, AddressView, "address.json"), success: true}
  end

  @doc """
  Renders address data.
  """
  def render("address.json", %{address: address}) do
    %{
      id: address.id,
      alias: address.alias,
      street: address.street,
      number: address.number,
      complement: address.complement,
      neighborhood: address.neighborhood,
      zip: address.zip,
      city_id: address.city_id,
      person_id: address.person_id
    }
  end
end
