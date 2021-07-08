defmodule Example do
  @moduledoc """
  This example app shows a User -> Role -> Permission relationship defined by
  `many_to_many` where the primary key for the user is a UUID.

  The User `id` is defined as `:uuid` type in the migration but as `:binary_id`
  in the schema.

  Using `Ecto.assoc(user, :permissions)` with a user fetched from the database
  results in a `DBConnection.EncodeError` because the `id` has not been cast to
  a uuid when it was fetched from the database.

  Is this a configuration issue?
  """
end
