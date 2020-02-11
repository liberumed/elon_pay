defmodule ElonPay.Repo do
  use Ecto.Repo,
    otp_app: :elon_pay,
    adapter: Ecto.Adapters.Postgres
end
