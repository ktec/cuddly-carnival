defmodule ExampleTest do
  use ExUnit.Case
  doctest Example

  setup do
    # create user
    %{
      user: Ecto.Changeset.cast(%User{}, %{}, []) |> Repo.insert!()
    }
  end

  test "results in an error", %{user: user} do
    # fetch permissions
    permissions = Ecto.assoc(user, :permissions) |> Repo.all()

    assert permissions == []
  end

  test "the uuid is a binary", %{user: user} do
    assert is_binary(user.id)
  end

  test "the uuid is correct bytesize", %{user: user} do
    assert byte_size(user.id) == 16
  end

  test "works", %{user: user} do
    # fetch permissions
    permissions =
      user
      |> Map.put(:id, Ecto.UUID.dump!(user.id))
      |> Ecto.assoc(:permissions)
      |> Repo.all()

    assert permissions == []
  end
end
