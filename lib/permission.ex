defmodule Permission do
  @moduledoc false

  use Ecto.Schema

  schema "permissions" do
    field(:resource_name, :string)

    belongs_to(:role, Role)
  end
end
