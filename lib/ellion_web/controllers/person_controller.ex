defmodule EllionWeb.PersonController do
  use EllionWeb, :controller

  alias Ellion.Registry
  alias Ellion.Registry.Person

  action_fallback EllionWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", persons: Registry.list_persons())
  end

  def create(conn, %{"person" => person_params}) do
    with {:ok, %Person{} = person} <- Registry.create_person(person_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.person_path(conn, :show, person))
      |> render("show.json", person: person)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Person{} = person} <- Registry.get_person(id) do
      render(conn, "show.json", person: person)
    end
  end

  def update(conn, %{"id" => id, "person" => person_params}) do
    with {:ok, %Person{} = person} <- Registry.get_person(id),
         {:ok, %Person{} = person} <- Registry.update_person(person, person_params) do
      render(conn, "show.json", person: person)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Person{} = person} <- Registry.get_person(id),
         {:ok, %Person{}} <- Registry.delete_person(person) do
      send_resp(conn, :no_content, "")
    end
  end
end
