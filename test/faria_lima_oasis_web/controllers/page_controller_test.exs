defmodule FariaLimaOasisWeb.PageControllerTest do
  use FariaLimaOasisWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end
end
