defmodule Todo.Repo.Migrations.AddPasswordToCredential do
  use Ecto.Migration

  def change do
    alter table(:credentials) do
      add :hashed_password, :string
    end
  end
end
