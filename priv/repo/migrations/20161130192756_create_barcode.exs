defmodule Micro.Repo.Migrations.CreateBarcode do
  use Ecto.Migration

  def change do
    create table(:barcodes) do
      add :barcode, :string
      add :type, :string

      add :product_id, references(:products)
      timestamps()
    end

  end
end
