defmodule FariaLimaOasisWeb.PageController do
  use FariaLimaOasisWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
