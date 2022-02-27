defmodule CleaningHubWeb.SessionController do
  use CleaningHubWeb, :controller

  alias CleaningHub.Account
  alias CleaningHub.Account.Guardian

  action_fallback CleaningHubWeb.FallbackController

  def new(conn,%{"email" => email, "password" => password}) do
    case Account.authenticate(email, password) do
      {:ok, user} ->
        {:ok, access_token, _claims} =
          Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {15, :minute})

        {:ok, refresh_token, _claims} =
          Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {7, :day})

          conn
          |> put_resp_cookie("ruid", refresh_token)
          |> put_status(:created)
          |> render("token.json", access_token: access_token)

      {:error, :unauthorized} ->
        conn
        |> put_status(401)
        |> render("error.json", error: "Unauthorized")
    end
  end

  def refresh(conn, _params) do
    refresh_token = Plug.Conn.fetch_cookies(conn) |> Map.from_struct() |> get_in([:cookies, "ruid"])

    case Guardian.exchange(refresh_token, "refresh", "access") do
      {:ok, _old_stuff, {new_access_token, _new_claims}} ->
        conn
          |> put_status(:created)
          |> render("token.json", access_token: new_access_token)

      {:error, _reason} ->
        conn
        |> put_status(401)
        |> render("error.json", error: "Unauthorized")
    end
  end

  def delete(conn, _params) do
    body = Jason.encode!(%{message: "Log out successful."})
    conn
    |> delete_resp_cookie("ruid")
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end


end
