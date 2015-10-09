defmodule Things.Repo.Migrations.CreateTodo do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :text, :string
      add :complete, :boolean, default: false, null: false

      timestamps
    end

  end
end
