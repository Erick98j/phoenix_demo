defmodule Qualitas.Repo do
  use Ecto.Repo,
    otp_app: :qualitas,
    adapter: Ecto.Adapters.Postgres
end
