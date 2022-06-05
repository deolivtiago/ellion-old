defmodule EllionWeb.StateView do
  use EllionWeb, :view

  alias EllionWeb.StateView

  @doc """
  Renders a list of states.
  """
  def render("index.json", %{states: states}) do
    %{data: render_many(states, StateView, "state.json"), success: true}
  end

  @doc """
  Renders a single state.
  """
  def render("show.json", %{state: state}) do
    %{data: render_one(state, StateView, "state.json"), success: true}
  end

  @doc """
  Renders state data.
  """
  def render("state.json", %{state: state}) do
    %{
      id: state.id,
      code: state.code,
      name: state.name,
      country_id: state.country_id
    }
  end
end
