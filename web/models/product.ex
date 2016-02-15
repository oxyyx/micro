defmodule Micro.Product do
  use Micro.Web, :model

  schema "products" do
    field :description, :string
    field :sellable, :boolean, default: false
    field :buyable, :boolean, default: false

    belongs_to :category, Micro.Category
    has_many :sellingprices, Micro.SellingPrice, foreign_key: :product_id

    timestamps
  end

  @required_fields ~w(description sellable buyable)
  @optional_fields ~w(category_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
