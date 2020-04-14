defmodule Gaibu.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    sch = Application.fetch_env!(:gaibu, :http)
    pt = Application.fetch_env!(:gaibu, :port)
    IO.inspect(sch)
    IO.inspect(pt)
    children = [
      Gaibu.Repo,
      Plug.Cowboy.child_spec(scheme: sch, plug: Gaibu.Router, port: pt)
      # Starts a worker by calling: Gaibu.Worker.start_link(arg)
      # {Gaibu.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gaibu.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
