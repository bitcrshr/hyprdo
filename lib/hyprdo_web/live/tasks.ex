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
        <HyprdoWeb.Component.Task.card  :for={task <- @tasks} task={task} />
      </div>
    """
  end


  def handle_info(task, socket) do
    Logger.info("got task crud notification: #{inspect(task)}")
    tasks = Hyprdo.Repo.all(Hyprdo.Model.Task)
    {:noreply, assign(socket, :tasks, tasks)}
  end

  def handle_event("delete_task", %{"id" => id}, socket) do
    {:ok, _ } = Hyprdo.Repo.delete(%Hyprdo.Model.Task{id: id})

    tasks = Hyprdo.Repo.all(Hyprdo.Model.Task)

    {:noreply, assign(socket, :tasks, tasks)}
  end
end

defmodule HyprdoWeb.Component.Task do
  use HyprdoWeb, :html

  require Logger

  attr :task, Hyprdo.Model.Task, required: true

  def card(assigns) do
    ~H"""
    <div class="bg-background-700 text-text-100 p-1 w-[300px] flex flex-col rounded-lg shadow-lg">
      <div class="flex flex-col pl-1">
          <h3 class="text-lg">{@task.title}</h3>

        <p class="text-small italic">{@task.description}</p>
      </div>
      <div class="flex justify-end items-center gap-1">
        <Icons.trash onclick="delete_task" id={@task.id} class="size-5 hover:text-primary-500" />
        <Icons.checkbox class="size-5 hover:text-primary-500" />
      </div>
    </div>
    """
  end
end
