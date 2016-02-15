defmodule Micro.Repo.Migrations.CreateSellingPrice do
  use Ecto.Migration

  def change do
    create table(:sellingprices) do
      add :price, :decimal
      add :startdate, :date

      add :product_id, references(:products)
      timestamps
    end

  end
end
