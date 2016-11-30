defmodule Micro.BarcodeTest do
  use Micro.ModelCase

  alias Micro.Barcode

  @valid_attrs %{barcode: "some content", type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Barcode.changeset(%Barcode{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Barcode.changeset(%Barcode{}, @invalid_attrs)
    refute changeset.valid?
  end
end
