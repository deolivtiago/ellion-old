defmodule EllionWeb.StateController do
  use EllionWeb, :controller

  alias Ellion.Geo
  alias Ellion.Geo.Country
  alias Ellion.Geo.State

  action_fallback EllionWeb.FallbackController

  def index(conn, _params) do
    states = Geo.list_states()
    render(conn, "index.json", states: states)
  end

  def create(conn, %{"country_id" => country_id, "state" => state_params}) do
    with {:ok, %Country{}} <- Geo.get_country(country_id) do
      state_params = Map.put(state_params, "country_id", country_id)

      with {:ok, %State{} = state} <- Geo.create_state(state_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.country_state_path(conn, :show, country_id, state))
        |> render("show.json", state: state)
      end
    end
  end

  def show(conn, %{"country_id" => country_id, "id" => id}) do
    with {:ok, %State{} = state} <- get_state(country_id, id) do
      render(conn, "show.json", state: state)
    end
  end

  def update(conn, %{"country_id" => country_id, "id" => id, "state" => state_params}) do
    with {:ok, %State{} = state} <- get_state(country_id, id),
         {:ok, %State{} = state} <- Geo.update_state(state, state_params) do
      render(conn, "show.json", state: state)
    end
  end

  def delete(conn, %{"country_id" => country_id, "id" => id}) do
    with {:ok, %State{} = state} <- get_state(country_id, id),
         {:ok, %State{}} <- Geo.delete_state(state) do
      send_resp(conn, :no_content, "")
    end
  end

  defp get_state(country_id, id) do
    with {:ok, %Country{}} <- Geo.get_country(country_id) do
      Geo.get_state(id)
    end
  end
end
