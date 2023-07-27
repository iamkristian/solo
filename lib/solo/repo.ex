defmodule Solo.Repo do
  use Ecto.Repo,
    otp_app: :solo,
    adapter: Ecto.Adapters.Postgres
end
