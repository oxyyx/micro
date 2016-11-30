defmodule Micro.ProductController do
  use Micro.Web, :controller

  alias Micro.Product

  plug :scrub_params, "product" when action in [:create, :update]
  # plug :set_language

  # defp set_language(conn, _opts) do
  #   Gettext.put_locale Micro.Gettext, "nl"
  #   conn
  # end

  def index(conn, _params) do
    products = Repo.all(Product)
    |> Repo.preload(:category)

    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{})
    query = from c in Micro.Category,
            select: {c.name, c.id}

    categories = Repo.all(query)
    all_categories = List.insert_at(categories, 0, {"", nil})

    render(conn, "new.html", changeset: changeset, categories: all_categories)
  end

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{}, product_params)

    case Repo.insert(changeset) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: product_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)
    |> Repo.preload [:barcodes, sellingprices: from(c in Micro.SellingPrice, order_by: c.startdate)]

    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)
    changeset = Product.changeset(product)

    query = from c in Micro.Category,
            select: {c.name, c.id}

    categories = Repo.all(query)
    all_categories = List.insert_at(categories, 0, {"", nil})

    render(conn, "edit.html", product: product, changeset: changeset, categories: all_categories)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Repo.get!(Product, id)
    changeset = Product.changeset(product, product_params)

    case Repo.update(changeset) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: product_path(conn, :show, product))
      {:error, changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: product_path(conn, :index))
  end
end
