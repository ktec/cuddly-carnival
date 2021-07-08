defmodule UsersRoles do
  @moduledoc false

  use Ecto.Schema

  schema "users_roles" do
    belongs_to(:user, User)
    belongs_to(:role, Role)
  end
end
