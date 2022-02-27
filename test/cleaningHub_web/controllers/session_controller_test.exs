defmodule CleaningHubWeb.SessionControllerTest do
  use CleaningHubWeb.ConnCase

  import CleaningHub.AccountFixtures

  @login_attrs %{
    email: "someemail@gmail.com",
    password: "some password"
  }

  @invalid_attrs %{email: "wrongemail@gmail", password: "wrongpassword@gmail"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "login user" do
    setup [:create_user]
    test "when data is valid", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :new), @login_attrs)
      assert %{"access_token" => access_token} = json_response(conn, 201)
      assert %{
        "access_token" => ^access_token
      } = json_response(conn, 201)

    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :new), @invalid_attrs)
      assert json_response(conn, 401)["error"] == "Unauthorized"
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

end
