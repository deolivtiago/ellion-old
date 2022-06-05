defmodule Ellion.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :alias, :string, size: 50
      add :name, :string, size: 150, null: false
      add :social_id, :string, size: 15, null: false
      add :type, :integer, null: false

      timestamps()
    end
  end
end
