defmodule Gaibu.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    sch = Application.fetch_env!(:gaibu, :http)
    {pt, _} = Integer.parse(Application.fetch_env!(:gaibu, :port))
    sch = String.to_atom(sch)
    children = [
      Gaibu.Repo,
      Plug.Cowboy.child_spec(scheme: sch, plug: Gaibu.Router, options: [port: pt])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gaibu.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
