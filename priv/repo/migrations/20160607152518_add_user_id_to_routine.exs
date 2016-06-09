defmodule Mroutinez.Repo.Migrations.AddUserIdToRoutine do
  use Ecto.Migration

  def change do
    alter table(:routines) do
      add :user_id, :integer
    end
  end
end
