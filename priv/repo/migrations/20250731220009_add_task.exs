defmodule Hyprdo.Repo.Migrations.AddTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, [null: false]
      add :description, :string, [null: false]
    end
  end
end
