defmodule MuffinApi.Repo do
  use Ecto.Repo,
    otp_app: :muffin_api,
    adapter: Ecto.Adapters.Postgres
end
