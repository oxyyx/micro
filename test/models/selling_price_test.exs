defmodule Micro.SellingPriceTest do
  use Micro.ModelCase

  alias Micro.SellingPrice

  @valid_attrs %{price: "120.5", startdate: "2010-04-17"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SellingPrice.changeset(%SellingPrice{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SellingPrice.changeset(%SellingPrice{}, @invalid_attrs)
    refute changeset.valid?
  end
end
