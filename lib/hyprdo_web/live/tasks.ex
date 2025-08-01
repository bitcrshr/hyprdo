defmodule HyprdoWeb.Live.Tasks do
  use HyprdoWeb, :live_view

  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(Hyprdo.PubSub, "task-crud")

    tasks = Hyprdo.Repo.all(Hyprdo.Model.Task)

    {:ok, assign(socket, :tasks, tasks)}
  end

  def render(assigns) do
    ~H"""
      <div class="w-full h-screen flex items-center justify-center">
        <div class="w-1/2 rounded-lg shadow-lg flex flex-col gap-[10px]">
          <div :for={task <- @tasks} class="p-4 flex flex-col gap-2">
            <h3>{task.title}</h3>
            <code>{task.id}</code>
            <p>{task.description}</p>
          </div>
        </div>
      </div>
    """
  end

  def handle_info(task, socket) do
    {:noreply, assign(socket, tasks: socket.assigns.tasks ++ [task])}
  end
end
