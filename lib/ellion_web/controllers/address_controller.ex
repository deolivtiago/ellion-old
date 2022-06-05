defmodule EllionWeb.AddressController do
  use EllionWeb, :controller

  alias Ellion.Registry
  alias Ellion.Registry.Address
  alias Ellion.Registry.Person

  action_fallback EllionWeb.FallbackController

  def index(conn, %{"person_id" => person_id}) do
    with {:ok, %Person{}} <- Registry.get_person(person_id) do
      render(conn, "index.json", addresses: Registry.list_addresses())
    end
  end

  def create(conn, %{"person_id" => person_id, "address" => address_params}) do
    with {:ok, %Person{}} <- Registry.get_person(person_id) do
      address_params = Map.put(address_params, "person_id", person_id)

      with {:ok, %Address{} = address} <- Registry.create_address(address_params) do
        conn
        |> put_status(:created)
        |> put_resp_header(
          "location",
          Routes.person_address_path(conn, :show, person_id, address)
        )
        |> render("show.json", address: address)
      end
    end
  end

  def show(conn, %{"person_id" => person_id, "id" => id}) do
    with {:ok, %Address{} = address} <- get_address(person_id, id) do
      render(conn, "show.json", address: address)
    end
  end

  def update(conn, %{"person_id" => person_id, "id" => id, "address" => address_params}) do
    with {:ok, %Address{} = address} <- get_address(person_id, id),
         {:ok, %Address{} = address} <- Registry.update_address(address, address_params) do
      render(conn, "show.json", address: address)
    end
  end

  def delete(conn, %{"person_id" => person_id, "id" => id}) do
    with {:ok, %Address{} = address} <- get_address(person_id, id),
         {:ok, %Address{}} <- Registry.delete_address(address) do
      send_resp(conn, :no_content, "")
    end
  end

  defp get_address(person_id, id) do
    with {:ok, %Person{}} <- Registry.get_person(person_id) do
      Registry.get_address(id)
    end
  end
end
