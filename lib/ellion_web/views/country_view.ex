defmodule EllionWeb.CountryView do
  use EllionWeb, :view

  alias EllionWeb.CountryView

  @doc """
  Renders a list of countries.
  """
  def render("index.json", %{countries: countries}) do
    %{data: render_many(countries, CountryView, "country.json"), success: true}
  end

  @doc """
  Renders a single country.
  """
  def render("show.json", %{country: country}) do
    %{data: render_one(country, CountryView, "country.json"), success: true}
  end

  @doc """
  Renders country data.
  """
  def render("country.json", %{country: country}) do
    %{
      id: country.id,
      code: country.code,
      name: country.name
    }
  end
end
