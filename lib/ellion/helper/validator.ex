defmodule Ellion.Utils.Validator do
  @moduledoc """
  Validation utilities.
  """

  @doc """
  Casts uuid.

  Returns nil when invalid.
  """
  def cast_uuid(id) do
    case Ecto.UUID.cast(id) do
      {:ok, _uuid} -> id
      _ -> nil
    end
  end

  @doc """
  Validates a uuid.
  """
  def valid?(id), do: cast_uuid(id) != nil
end
