defmodule Micro.SellingPriceController do
  use Micro.Web, :controller

  alias Micro.SellingPrice

  plug :scrub_params, "selling_price" when action in [:create, :update]

  def index(conn, _params) do
    sellingprices = Repo.all(SellingPrice)
    render(conn, "index.html", sellingprices: sellingprices)
  end

  def new(conn, _params) do
    changeset = SellingPrice.changeset(%SellingPrice{})

    query = from c in Micro.Product,
            select: {c.description, c.id}

    products = Repo.all(query)
    all_products = List.insert_at(products, 0, {"", nil})

    render(conn, "new.html", changeset: changeset, products: all_products)
  end

  def create(conn, %{"selling_price" => selling_price_params}) do
    changeset = SellingPrice.changeset(%SellingPrice{}, selling_price_params)

    case Repo.insert(changeset) do
      {:ok, _selling_price} ->
        conn
        |> put_flash(:info, "Selling price created successfully.")
        |> redirect(to: selling_price_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    selling_price = Repo.get!(SellingPrice, id)
    render(conn, "show.html", selling_price: selling_price)
  end

  def edit(conn, %{"id" => id}) do
    selling_price = Repo.get!(SellingPrice, id)
    changeset = SellingPrice.changeset(selling_price)

    query = from c in Micro.Product,
            select: {c.description, c.id}

    products = Repo.all(query)
    all_products = List.insert_at(products, 0, {"", nil})

    render(conn, "edit.html", selling_price: selling_price, changeset: changeset, products: all_products)
  end

  def update(conn, %{"id" => id, "selling_price" => selling_price_params}) do
    selling_price = Repo.get!(SellingPrice, id)
    changeset = SellingPrice.changeset(selling_price, selling_price_params)

    case Repo.update(changeset) do
      {:ok, selling_price} ->
        conn
        |> put_flash(:info, "Selling price updated successfully.")
        |> redirect(to: selling_price_path(conn, :show, selling_price))
      {:error, changeset} ->
        render(conn, "edit.html", selling_price: selling_price, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    selling_price = Repo.get!(SellingPrice, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(selling_price)

    conn
    |> put_flash(:info, "Selling price deleted successfully.")
    |> redirect(to: selling_price_path(conn, :index))
  end
end
