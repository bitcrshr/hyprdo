defmodule Hyprdo.Model.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key { :id, Ecto.UUID, autogenerate: true }
  schema "tasks" do
    field :title, :string
    field :description, :string
    field :status, Ecto.Enum, values: [:TASK_STATUS_UNSPECIFIED, :TODO, :IN_PROGRESS, :COMPLETED, :BLOCKED]
    field :due_at, :utc_datetime
    field :estimated_time, :duration
    field :actual_time, :duration

    timestamps(inserted_at: :created_at, type: :utc_datetime)
  end

  def changeset(%Hyprdo.Tasks.V1.Task{} = task) do
    Hyprdo.Model.Task.changeset(%Hyprdo.Model.Task{}, task |> PbTask.db_task() |> Map.from_struct())
  end

  def changeset(%Hyprdo.Model.Task{} = task, params \\ %{}) do
    task
    |> cast(params, [:title, :description, :status, :due_at, :estimated_time])
    |> validate_change(:title, fn :title, title ->
      if String.length(title) == 0 do
        [title: "title cannot be empty"]
      else
        []
      end
    end)
    |> validate_change(:status, fn :status, status ->
      if status == :TASK_STATUS_UNSPECIFIED do
        [status: "status must be specified"]
      else
        []
      end
    end)
  end



end
