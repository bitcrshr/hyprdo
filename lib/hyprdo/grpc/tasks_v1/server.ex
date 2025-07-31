defmodule Hyprdo.GrpcEndpoint do
  use GRPC.Endpoint

  intercept GRPC.Server.Interceptors.Logger

  run HyprdoStreams.Server
  run Hyprdo.Reflection.ServerV1
  run Hyprdo.Reflection.ServerV1Alpha
end

defmodule Hyprdo.Reflection.ServerV1 do
  use GrpcReflection.Server,
  version: :v1,
  services: [Hyprdo.Tasks.V1.TasksService.Service]
end

defmodule Hyprdo.Reflection.ServerV1Alpha do
  use GrpcReflection.Server,
  version: :v1alpha,
  services: [Hyprdo.Tasks.V1.TasksService.Service]
end

defmodule HyprdoStreams.Server do
  use GRPC.Server, service: Hyprdo.Tasks.V1.TasksService.Service

  require Logger
  alias Hyprdo.Tasks.V1, as: TasksV1

  alias Hyprdo.{Model, Repo}
  alias GRPC.RPCError


  @spec get_one_task(TasksV1.GetOneTaskRequest.t(), GRPC.Server.Stream.t()) :: TasksV1.GetOneTaskResponse.t()
  def get_one_task(req, _stream) do
    { :ok, taskId } = Ecto.UUID.cast(req.id)

    case Repo.get(Model.Task, taskId) do
      nil -> raise RPCError, status: :not_found, message: "task with id #{taskId} not found"
      task -> %TasksV1.GetOneTaskResponse{ task: task }
    end 
  end
end
