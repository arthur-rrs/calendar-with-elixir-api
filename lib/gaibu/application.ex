defmodule Gaibu.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Gaibu.Repo,
      Plug.Cowboy.child_spec(scheme: :http, plug: Gaibu.Router, port: 4001)
      # Starts a worker by calling: Gaibu.Worker.start_link(arg)
      # {Gaibu.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gaibu.Supervisor]
    Supervisor.start_link(children, opts)
  end
end