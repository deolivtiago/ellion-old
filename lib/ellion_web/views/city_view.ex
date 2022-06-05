defmodule EllionWeb.CityView do
  use EllionWeb, :view

  alias EllionWeb.CityView

  @doc """
  Renders a list of cities.
  """
  def render("index.json", %{cities: cities}) do
    %{data: render_many(cities, CityView, "city.json"), success: true}
  end

  @doc """
  Renders a single city.
  """
  def render("show.json", %{city: city}) do
    %{data: render_one(city, CityView, "city.json"), success: true}
  end

  @doc """
  Renders city data.
  """
  def render("city.json", %{city: city}) do
    %{
      id: city.id,
      name: city.name,
      state_id: city.state_id
    }
  end
end
