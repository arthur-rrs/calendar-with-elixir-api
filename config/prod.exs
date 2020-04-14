import Config

config :gaibu, Gaibu.Repo,
  ssl: true,
  url: System.get_env("DATABASE_URL")

config :gaibu, ecto_repos: [Gaibu.Repo]

config :gaibu, Gaibu.Token,
  issuer: "gaibu",
  secret_key: System.get_env("SECRET")

config :gaibu,
  port: System.get_env("PORT"),
  http: :https
