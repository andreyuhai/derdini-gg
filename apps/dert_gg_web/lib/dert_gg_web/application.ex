defmodule DertGGWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: DertGGWeb.PubSub},
      # Start the Telemetry supervisor
      DertGGWeb.Telemetry,
      # Start the Endpoint (http/https)
      DertGGWeb.Endpoint
      # Start a worker by calling: DertGGWeb.Worker.start_link(arg)
      # {DertGGWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DertGGWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DertGGWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
