defmodule HyprdoWeb.Live.Tasks do
  use HyprdoWeb, :live_view

  require Logger

  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(Hyprdo.PubSub, "task-crud")

    tasks = Hyprdo.Repo.all(Hyprdo.Model.Task)

    {:ok, assign(socket, :tasks, tasks)}
  end

  def render(assigns) do
    ~H"""
      <div class="w-full h-screen flex items-center justify-center">
        <HyprdoWeb.Component.Task.task :for={task <- @tasks} task={task} />
      </div>
    """
  end

  # def handle_info(task, socket) do
  #   {:noreply, assign(socket, tasks: socket.assigns.tasks ++ [task])}
  # end

  # def handle_event("delete", params, socket) do
  #   {:ok, _ } = Hyprdo.Repo.delete(%Hyprdo.Model.Task{id: params["taskid"]})

  #   tasks = Hyprdo.Repo.all(Hyprdo.Model.Task)
    
  #   {:noreply, assign(socket, :tasks, tasks)}
  # end
end

defmodule HyprdoWeb.Component.Task do
  use Phoenix.Component

  attr :task, Hyprdo.Model.Task, required: true

  def task(assigns) do
    ~H"""
    <div class="p-3 w-[300px] flex flex-col rounded-lg shadow-lg">
      <h1 class="font-bold">{@task.title}</h1>

      <p>{@task.description}</p>
      <p>{@task.created_at}</p>
    </div>
    """
  end
end
