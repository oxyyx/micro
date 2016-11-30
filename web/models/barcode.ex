defmodule Micro.Barcode do
  use Micro.Web, :model

  schema "barcodes" do
    field :barcode, :string
    field :type, :string

    belongs_to :product, Micro.Product

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:barcode, :type, :product_id])
    |> validate_required([:barcode, :type, :product_id])
  end
end
