defmodule Mroutinez.PageController do
  use Mroutinez.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
