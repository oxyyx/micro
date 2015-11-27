defmodule Micro.ProductTest do
  use Micro.ModelCase

  alias Micro.Product

  @valid_attrs %{buyable: true, description: "some content", sellable: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Product.changeset(%Product{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Product.changeset(%Product{}, @invalid_attrs)
    refute changeset.valid?
  end
end
