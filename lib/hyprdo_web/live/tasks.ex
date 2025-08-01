defmodule HyprdoWeb.Live.Tasks do
  use HyprdoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Hey</h1>
      <p>Count: {@count}</p>
      <button phx-click="inc">Increment</button>
    </div>
    """
  end

  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end
