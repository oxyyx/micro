defmodule Micro.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :description, :string
      add :sellable, :boolean, default: false
      add :buyable, :boolean, default: false

      timestamps
    end

  end
end
