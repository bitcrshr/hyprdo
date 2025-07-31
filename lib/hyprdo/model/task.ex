defmodule Hyprdo.Model.Task do
  use Ecto.Schema

  @primary_key { :id, Ecto.UUID, autogenerate: true }
  schema "tasks" do
    field :title, :string
    field :description, :string
  end
end
