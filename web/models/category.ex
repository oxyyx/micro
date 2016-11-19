defmodule Micro.Category do
  use Micro.Web, :model

  schema "categories" do
    field :name, :string

    belongs_to :category, Micro.Category

    has_many :subcategories, Micro.Category, foreign_key: :category_id
    has_many :products, Micro.Product, foreign_key: :category_id

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(category_id)

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
