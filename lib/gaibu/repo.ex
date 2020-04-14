defmodule Gaibu.Repo do
  adap = case Mix.env() do
              :dev -> Ecto.Adapters.MyXQL
              :prod -> Ecto.Adapters.Postgres
              :test -> Ecto.Adapters.MyXQL
          end
  use Ecto.Repo,
    otp_app: :gaibu,
    adapter: adap
end
