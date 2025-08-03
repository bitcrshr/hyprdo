defmodule Hyprdo.Repo.Migrations.AddTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, [null: false]
      add :description, :text, [null: false]
      add :status, :string, [null: false, default: to_string(:TASK_STATUS_UNSPECIFIED)]
      add :estimated_time, :duration
      add :actual_time, :duration

      add :due_at, :utc_datetime
      add :created_at, :utc_datetime, [null: false, default: fragment("CURRENT_TIMESTAMP")]
      add :updated_at, :utc_datetime, [null: true]
    end
  end
end
