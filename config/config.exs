import Config

config :gaibu, Gaibu.Repo,
  database: "gaibu_repo",
  username: "root",
  password: "123456",
  hostname: "localhost"

config :gaibu, ecto_repos: [Gaibu.Repo]

config :gaibu, Gaibu.Token,
  issuer: "gaibu",
  secret_key: "5yNh0bdcdcALffXz0eY5Kc3Fd/sr/2t3NNzxmyp9UoS48VJ2nKdFH8z17G1klyN0"
