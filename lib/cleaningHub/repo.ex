defmodule CleaningHub.Repo do
  use Ecto.Repo,
    otp_app: :cleaningHub,
    adapter: Ecto.Adapters.Postgres
end
