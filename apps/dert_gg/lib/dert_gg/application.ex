defmodule DertGG.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DertGG.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: DertGG.PubSub}
      # Start a worker by calling: DertGG.Worker.start_link(arg)
      # {DertGG.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: DertGG.Supervisor)
  end
end
