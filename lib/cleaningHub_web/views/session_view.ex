defmodule CleaningHubWeb.SessionView do
  use CleaningHubWeb, :view

  def render("token.json", %{access_token: access_token}) do
    %{access_token: access_token}
  end

  def render("error.json", %{error: error}) do
    %{error: error}
  end

end
