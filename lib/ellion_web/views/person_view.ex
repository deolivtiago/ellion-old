defmodule EllionWeb.PersonView do
  use EllionWeb, :view

  alias EllionWeb.PersonView

  @doc """
  Renders a list of persons.
  """
  def render("index.json", %{persons: persons}) do
    %{data: render_many(persons, PersonView, "person.json"), success: true}
  end

  @doc """
  Renders a single person.
  """
  def render("show.json", %{person: person}) do
    %{data: render_one(person, PersonView, "person.json"), success: true}
  end

  @doc """
  Renders person data.
  """
  def render("person.json", %{person: person}) do
    %{
      id: person.id,
      alias: person.alias,
      name: person.name,
      social_id: person.social_id,
      type: person.type
    }
  end
end
