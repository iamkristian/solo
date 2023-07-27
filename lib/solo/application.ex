defmodule Solo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SoloWeb.Telemetry,
      # Start the Ecto repository
      Solo.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Solo.PubSub},
      # Start Finch
      {Finch, name: Solo.Finch},
      # Start the Endpoint (http/https)
      SoloWeb.Endpoint
      # Start a worker by calling: Solo.Worker.start_link(arg)
      # {Solo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Solo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SoloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
