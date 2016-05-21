defmodule Mroutinez.Repo.Migrations.CreateRoutine do
  use Ecto.Migration

  def change do
    create table(:routines) do
      add :title, :string
      add :content, :string
      add :type, :string
      add :stars, :integer

      timestamps
    end

  end
end
