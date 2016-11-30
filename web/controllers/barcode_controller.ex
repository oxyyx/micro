defmodule Micro.BarcodeController do
  use Micro.Web, :controller

  alias Micro.Barcode

  plug :scrub_params, "barcode" when action in [:create, :update]
  plug :assign_product

  # def index(conn, _params) do
  #   barcodes = Repo.all(Barcode)
  #   render(conn, "index.html", barcodes: barcodes)
  # end

  def new(conn, _params) do
    changeset = 
    conn.assigns[:product]
    |> build_assoc(:barcodes)
    |> Barcode.changeset()

    render(conn, "new.html", product: conn.assigns[:product], changeset: changeset)
  end

  def create(conn, %{"barcode" => barcode_params}) do
    changeset = 
    conn.assigns[:product]
    |> build_assoc(:barcodes)
    |> Barcode.changeset(barcode_params)

    case Repo.insert(changeset) do
      {:ok, _barcode} ->
        conn
        |> put_flash(:info, "Barcode created successfully.")
        |> redirect(to: product_path(conn, :show, conn.assigns[:product]))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   barcode = Repo.get!(Barcode, id)
  #   render(conn, "show.html", barcode: barcode)
  # end

  def edit(conn, %{"id" => id}) do
    barcode = Repo.get!(Barcode, id)
    changeset = Barcode.changeset(barcode)

    query = from c in Micro.Product,
            select: {c.description, c.id}

    products = Repo.all(query)
    all_products = List.insert_at(products, 0, {"", nil})

    render(conn, "edit.html", barcode: barcode, changeset: changeset, products: all_products)
  end

  def update(conn, %{"id" => id, "barcode" => barcode_params}) do
    barcode = Repo.get!(Barcode, id)
    changeset = Barcode.changeset(barcode, barcode_params)

    case Repo.update(changeset) do
      {:ok, barcode} ->
        conn
        |> put_flash(:info, "Barcode updated successfully.")
        |> redirect(to: product_path(conn, :show, conn.assigns[:product]))
      {:error, changeset} ->
        render(conn, "edit.html", barcode: barcode, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    barcode = Repo.get!(Barcode, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(barcode)

    conn
    |> put_flash(:info, "Barcode deleted successfully.")
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
