defmodule CleaningHubWeb.GuardianPipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
  otp_app: :cleaningHub,
  module: CleaningHub.Account.Guardian,
  error_handler: CleaningHubWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, claims: @claims, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
end
