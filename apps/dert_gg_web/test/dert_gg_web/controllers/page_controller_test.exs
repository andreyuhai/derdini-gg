defmodule DertGGWeb.PageControllerTest do
  use DertGGWeb.ConnCase

  describe "GET /" do
    test "redirects to login if not logged in", %{conn: conn} do
      conn = get(conn, "/")

      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end
  end
end
