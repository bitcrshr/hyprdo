defmodule HyprdoStreams.Server do
  use GRPC.Server, service: Hyprdo.Tasks.V1.TasksService.Service

  require Logger
  alias Mix.PubSub
  alias Hyprdo.Tasks.V1, as: TasksV1

  alias Hyprdo.{Model, Repo}
  alias GRPC.RPCError

  @spec get_one_task(TasksV1.GetOneTaskRequest.t(), GRPC.Server.Stream.t()) ::
          TasksV1.GetOneTaskResponse.t()
  def get_one_task(%TasksV1.GetOneTaskRequest{ :id => id }, _stream) do
    case Repo.get(Model.Task, id) do
      nil -> raise RPCError, status: :not_found, message: "no task found with id #{id}"
      task -> PbTask.pb_task(task)
    end
  end

  @spec create_task(TasksV1.CreateTaskRequest.t(), GRPC.Server.Stream.t()) ::
          TasksV1.CreateTaskResponse.t()
  def create_task(%TasksV1.CreateTaskRequest{ :task => task }, _stream) do
    pb_task = case Model.Task.changeset(task) do
      %{ :errors => errors } when errors != []  -> raise RPCError, status: :invalid_argument, message: inspect(errors)
      changeset -> case Repo.insert(changeset, [returning: true]) do
        {:ok, db_task} -> PbTask.pb_task(db_task)
        {:error, errs} -> raise RPCError, status: :unknown, message: inspect(errs)
      end
    end

    Phoenix.PubSub.broadcast(Hyprdo.PubSub, "task-crud", pb_task)

    %TasksV1.CreateTaskResponse{task: pb_task}
  end

  @spec list_tasks(TasksV1.ListTasksRequest.t(), GRPC.Server.Stream.t()) ::
          TasksV1.ListTasksResponse.t()
  def list_tasks(_req, _stream) do
    pb_tasks = Repo.all(Model.Task) |> Enum.map(&PbTask.pb_task/1)

    %TasksV1.ListTasksResponse{tasks: pb_tasks}
  end

  @spec delete_task(TasksV1.DeleteTaskRequest.t(), GRPC.Server.Stream.t()) ::
          TasksV1.DeleteTaskResponse.t()
  def delete_task(%TasksV1.DeleteTaskRequest{ :id => id }, _stream) do
    case Repo.delete(%Model.Task{id: id}) do
      {:ok, task} ->
        Phoenix.PubSub.broadcast(Hyprdo.PubSub, "task-crud", PbTask.pb_task(task))

        %Google.Protobuf.Empty{}
      {:error, errs} -> raise RPCError, status: :unknown, message: inspect(errs) 
    end
  end
end
