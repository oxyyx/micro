defmodule Micro.SellingPriceControllerTest do
  use Micro.ConnCase

  alias Micro.SellingPrice
  @valid_attrs %{price: "120.5", startdate: "2010-04-17"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, selling_price_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sellingprices"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, selling_price_path(conn, :new)
    assert html_response(conn, 200) =~ "New selling price"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, selling_price_path(conn, :create), selling_price: @valid_attrs
    assert redirected_to(conn) == selling_price_path(conn, :index)
    assert Repo.get_by(SellingPrice, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, selling_price_path(conn, :create), selling_price: @invalid_attrs
    assert html_response(conn, 200) =~ "New selling price"
  end

  test "shows chosen resource", %{conn: conn} do
    selling_price = Repo.insert! %SellingPrice{}
    conn = get conn, selling_price_path(conn, :show, selling_price)
    assert html_response(conn, 200) =~ "Show selling price"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, selling_price_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    selling_price = Repo.insert! %SellingPrice{}
    conn = get conn, selling_price_path(conn, :edit, selling_price)
    assert html_response(conn, 200) =~ "Edit selling price"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    selling_price = Repo.insert! %SellingPrice{}
    conn = put conn, selling_price_path(conn, :update, selling_price), selling_price: @valid_attrs
    assert redirected_to(conn) == selling_price_path(conn, :show, selling_price)
    assert Repo.get_by(SellingPrice, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    selling_price = Repo.insert! %SellingPrice{}
    conn = put conn, selling_price_path(conn, :update, selling_price), selling_price: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit selling price"
  end

  test "deletes chosen resource", %{conn: conn} do
    selling_price = Repo.insert! %SellingPrice{}
    conn = delete conn, selling_price_path(conn, :delete, selling_price)
    assert redirected_to(conn) == selling_price_path(conn, :index)
    refute Repo.get(SellingPrice, selling_price.id)
  end
end
