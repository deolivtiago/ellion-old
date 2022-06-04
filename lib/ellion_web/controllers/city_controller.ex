defmodule EllionWeb.CityController do
  use EllionWeb, :controller

  alias Ellion.Geo
  alias Ellion.Geo.City
  alias Ellion.Geo.Country
  alias Ellion.Geo.State

  action_fallback EllionWeb.FallbackController

  def index(conn, %{"country_id" => country_id, "state_id" => state_id}) do
    with {:ok, %Country{}} <- Geo.get_country(country_id),
         {:ok, %State{}} <- Geo.get_state(state_id) do
      render(conn, "index.json", cities: Geo.list_cities())
    end
  end

  def create(conn, %{"country_id" => country_id, "state_id" => state_id, "city" => city_params}) do
    with {:ok, %State{}} <- Geo.get_state(state_id) do
      city_params = Map.put(city_params, "state_id", state_id)

      with {:ok, %City{} = city} <- Geo.create_city(city_params) do
        conn
        |> put_status(:created)
        |> put_resp_header(
          "location",
          Routes.country_state_city_path(conn, :show, country_id, state_id, city)
        )
        |> render("show.json", city: city)
      end
    end
  end

  def show(conn, %{"country_id" => country_id, "state_id" => state_id, "id" => id}) do
    with {:ok, %City{} = city} <- get_city(country_id, state_id, id) do
      render(conn, "show.json", city: city)
    end
  end

  def update(conn, %{
        "country_id" => country_id,
        "state_id" => state_id,
        "id" => id,
        "city" => city_params
      }) do
    with {:ok, %City{} = city} <- get_city(country_id, state_id, id),
         {:ok, %City{} = city} <- Geo.update_city(city, city_params) do
      render(conn, "show.json", city: city)
    end
  end

  def delete(conn, %{"country_id" => country_id, "state_id" => state_id, "id" => id}) do
    with {:ok, %City{} = city} <- get_city(country_id, state_id, id),
         {:ok, %City{}} <- Geo.delete_city(city) do
      send_resp(conn, :no_content, "")
    end
  end

  defp get_city(country_id, state_id, id) do
    with {:ok, %Country{}} <- Geo.get_country(country_id),
         {:ok, %State{}} <- Geo.get_state(state_id) do
      Geo.get_city(id)
    end
  end
end
