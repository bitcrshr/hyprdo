
defmodule Scheduler do
  use GenServer

  require Logger

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def enqueue(tasks) when is_list(tasks) do
    GenServer.cast(__MODULE__, {:enqueue, tasks})
  end

  def enqueue(task) do
    GenServer.cast(__MODULE__, {:enqueue, task})
  end

  @impl true
  def init(_args) do
    Logger.info("Scheduler starting up!")

    {:ok, []}
  end

  @impl true
  def handle_cast({:enqueue, tasks} = msg, queue) when is_list(tasks) do
    Logger.debug("Received tasks: #{inspect(tasks)}")
    {:noreply, queue ++ tasks}
  end

  @impl true
  def handle_cast({:enqueue, task} = msg, queue) do
    Logger.debug("Received tasks: [#{inspect(task)}]")
    {:noreply, queue ++ [task]}
  end

  @impl true
  def terminate(reason, state) do
    Logger.warn("Scheduler terminating with reason: #{reason} and state #{inspect(state)}")
    :ok
  end
end
