defmodule Hyprdo.GrpcEndpoint do
  use GRPC.Endpoint

  intercept GRPC.Server.Interceptors.Logger

  run(HyprdoStreams.Server)
  run(Hyprdo.Reflection.ServerV1)
  run(Hyprdo.Reflection.ServerV1Alpha)
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

  @spec get_one_task(TasksV1.GetOneTaskRequest.t(), GRPC.Server.Stream.t()) ::
          TasksV1.GetOneTaskResponse.t()
  def get_one_task(req, _stream) do
    case Ecto.UUID.cast(req.id) do
      :error ->
        raise RPCError, status: :invalid_argument, message: "#{req.id} is not a valid uuid"

      {:ok, taskId} ->
        case Repo.get(Model.Task, taskId) do
          nil -> raise RPCError, status: :not_found, message: "task with id #{taskId} not found"
          task -> %TasksV1.GetOneTaskResponse{task: task}
        end
    end
  end

  @spec create_task(TasksV1.CreateTaskRequest.t(), GRPC.Server.Stream.t()) ::
          TasksV1.CreateTaskResponse.t()
  def create_task(req, _stream) do
    task = case req.task do
      [title: ""] ->
        raise RPCError, status: :not_found, message: "task.title is required"

      _ ->
        case Repo.insert(%Model.Task{
          title: req.task.title,
          description: req.task.description,
        }, [returning: true]) do
          {:ok, task} -> %TasksV1.Task{
              id: task.id,
              title: task.title,
              description: task.description,
            }
          {:error, err} -> raise RPCError, status: :unknown, message: "error: #{err.errors}"
        end
    end

    %TasksV1.CreateTaskResponse{
      task: task,
    }
  end

  @spec list_tasks(TasksV1.ListTasksRequest.t(), GRPC.Server.Stream.t()) :: TasksV1.ListTasksResponse.t()
  def list_tasks(_req, _stream) do
    %TasksV1.ListTasksResponse{
      tasks: Enum.map(Repo.all(Model.Task), fn t -> 
        %TasksV1.Task{
          id: t.id,
          title: t.title,
          description: t.description,
        }
      end
      )
    }
  end

  @spec delete_task(TasksV1.DeleteTaskRequest.t(), GRPC.Server.Stream.t()) :: TasksV1.DeleteTaskResponse.t()
  def delete_task(req, _stream) do
    case req.id do
      "" -> raise RPCError, status: :uknown, message: "id is required"
      id -> Repo.delete(
          %Model.Task{ id: id }
        )
    end

    %Google.Protobuf.Empty{}
  end
end
