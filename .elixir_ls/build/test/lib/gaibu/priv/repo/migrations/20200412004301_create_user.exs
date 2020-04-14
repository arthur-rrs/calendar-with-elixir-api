defmodule Gaibu.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, size: 30
      add :name, :string, size: 100
      add :email, :string, size: 100
      add :password, :string, size: 100
      add :is_active, :boolean, default: 0
    end
  end
end
