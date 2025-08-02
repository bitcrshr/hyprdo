defmodule Hyprdo.Repo.Migrations.AddTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, [null: false]
      add :description, :string, [null: false]

      add :created_at, :utc_datetime, [null: false, default: fragment("CURRENT_TIMESTAMP")]
      add :updated_at, :utc_datetime, [null: true]
    end
  end
end
