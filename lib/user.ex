defmodule User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "users" do
    field(:email, :string)
    field(:password, :string)

    many_to_many(:roles, Role, join_through: "users_roles")
    # has_many(:users_roles, UsersRoles)
    # has_many(:roles, through: [:users_roles, :role])
    has_many(:permissions, through: [:roles, :permissions])
  end

  def changeset(params) do
    %User{}
    |> cast(params, [:email, :password])
  end

  def get_permissions(user) do
    user
    |> cast_id_as_uuid()
    |> Ecto.assoc(:permissions)
    |> Repo.all()
  end

  defp cast_id_as_uuid(%{id: id} = user) do
    # ensure user id is cast as uuid
    %{user| id: Ecto.UUID.dump!(id)}
  end
end
