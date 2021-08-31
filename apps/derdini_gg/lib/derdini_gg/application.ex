defmodule DerdiniGG.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DerdiniGG.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: DerdiniGG.PubSub}
      # Start a worker by calling: DerdiniGG.Worker.start_link(arg)
      # {DerdiniGG.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: DerdiniGG.Supervisor)
  end
end
