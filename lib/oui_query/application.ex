defmodule OuiQuery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: OuiQuery.Worker.start_link(arg)
      # {OuiQuery.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    HTTPoison.start()
    opts = [strategy: :one_for_one, name: OuiQuery.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
