defmodule Hyprdo.Model.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key { :id, Ecto.UUID, autogenerate: true }
  schema "tasks" do
    field :title, :string
    field :description, :string
  end

  def changeset(task, params \\ %{}) do
    task
    |> cast(params, [:title, :description])
    |> validate_required([:title])
  end
end
