defmodule Hyprdo.Repo.Migrations.AddTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :string
    end
  end
end
