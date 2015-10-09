defmodule Things.PageController do
  use Things.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
