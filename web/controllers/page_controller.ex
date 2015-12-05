defmodule Micro.PageController do
  use Micro.Web, :controller

  alias Micro.Product

  def index(conn, _params) do
    products = Repo.all(Product)
    render conn, "index.html", products: products
  end
end
