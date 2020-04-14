defmodule Gaibu.Repo do
  use Ecto.Repo,
    otp_app: :gaibu,
    adapter: Ecto.Adapters.MyXQL
end
