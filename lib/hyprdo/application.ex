defmodule Hyprdo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HyprdoWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:hyprdo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hyprdo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Hyprdo.Finch},
      Hyprdo.Repo,
      # Start a worker by calling: Hyprdo.Worker.start_link(arg)
      # {Hyprdo.Worker, arg},
      # Start to serve requests, typically the last entry
      Scheduler,
      GrpcReflection,
      {
        GRPC.Server.Supervisor, [
          endpoint: Hyprdo.GrpcEndpoint,
          port: 50051,
          start_server: true,
        ]
      },
      HyprdoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hyprdo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HyprdoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
