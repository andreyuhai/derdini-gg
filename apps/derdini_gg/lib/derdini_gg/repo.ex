defmodule DerdiniGG.Repo do
  use Ecto.Repo,
    otp_app: :derdini_gg,
    adapter: Ecto.Adapters.Postgres
end
