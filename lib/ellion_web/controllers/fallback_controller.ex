defmodule EllionWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.
  """
  use EllionWeb, :controller

  @doc """
  Handles errors returned by Ecto's changeset.
  """
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(EllionWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
