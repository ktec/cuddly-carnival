defmodule Role do
  @moduledoc false

  use Ecto.Schema

  schema "roles" do
    field(:name, :string)

    has_many(:permissions, Permission)

    many_to_many(:users, User, join_through: "users_roles")
    # has_many(:users_roles, UsersRoles)
    # has_many(:users, through: [:users_roles, :user])
  end
end
