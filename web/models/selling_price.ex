defmodule Micro.SellingPrice do
  use Micro.Web, :model

  schema "sellingprices" do
    field :price, :decimal
    field :startdate, Ecto.Date

    belongs_to :product, Micro.Product

    timestamps
  end

  @required_fields ~w(price startdate product_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
