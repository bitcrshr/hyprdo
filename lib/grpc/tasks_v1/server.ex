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

  alias Hyprdo.Tasks.V1, as: TasksV1

  @spec get_one_task(TasksV1.GetOneTaskRequest.t(), GRPC.Server.Stream.t()) :: TasksV1.GetOneTaskResponse.t()
  def get_one_task(req, _stream) do
    %TasksV1.GetOneTaskResponse{
      task: %TasksV1.Task{
        id: req.id,
        title: "bar",
        description: "baz"
      }
    }
  end
end
