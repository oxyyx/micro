defmodule Micro.SellingPriceController do
  use Micro.Web, :controller

  alias Micro.SellingPrice

  plug :scrub_params, "selling_price" when action in [:create, :update]
  plug :assign_product

  def new(conn, _params) do
    changeset = 
    conn.assigns[:product]
    |> build_assoc(:sellingprices)
    |> SellingPrice.changeset()

    render(conn, "new.html", product: conn.assigns[:product], changeset: changeset)
  end

  def create(conn, %{"selling_price" => selling_price_params}) do
    changeset = 
    conn.assigns[:product]
    |> build_assoc(:sellingprices)
    |> SellingPrice.changeset(selling_price_params)

    case Repo.insert(changeset) do
      {:ok, _selling_price} ->
        conn
        |> put_flash(:info, "Selling price created successfully.")
        |> redirect(to: product_path(conn, :show, conn.assigns[:product]))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
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
        |> redirect(to: product_path(conn, :show, conn.assigns[:product]))
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
        |> redirect(to: product_path(conn, :show, conn.assigns[:product]))
  end

  defp assign_product(conn, _opts) do
    case conn.params do
      %{"product_id" => product_id} ->
        product = Repo.get(Micro.Product, product_id)
        assign(conn, :product, product)
      _ ->
        conn
    end
  end
end
