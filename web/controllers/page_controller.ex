defmodule Micro.PageController do
  use Micro.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
