defmodule Repo.Migrations.CreateRolesAndPermissions do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add(:name, :string, null: false)
    end

    create(unique_index(:roles, [:name]))

    create table(:users_roles) do
      add(:user_id, references(:users, type: :uuid, on_delete: :delete_all), null: false)
      add(:role_id, references(:roles, on_delete: :delete_all), null: false)
    end

    create(unique_index(:users_roles, [:user_id, :role_id]))

    create table(:permissions) do
      add(:role_id, references(:roles, on_delete: :delete_all), null: false)
      add(:resource_name, :string, null: false)
    end

    create(unique_index(:permissions, [:role_id, :resource_name]))
  end
end
