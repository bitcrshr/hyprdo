defmodule HyprdoWeb.TasksController do
  use HyprdoWeb, :controller

  def hello(conn, params) do
    name = params["name"] || "world"
    json(conn, %{greeting: "Hello, #{name}"})
  end
end
