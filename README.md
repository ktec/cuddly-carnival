# Example

This example app shows a User -> Role -> Permission relationship defined by
`many_to_many` where the primary key for the user is a UUID.

The User `id` is defined as `:uuid` type in the migration but as `:binary_id` in
the schema.

Using `Ecto.assoc(user, :permissions)` with a user fetched from the database
results in a `DBConnection.EncodeError` because the `id` has not been cast to a
uuid when it was fetched from the database.

To see the error you can run `mix test`:

```
  1) test results in an error (ExampleTest)
     test/example_test.exs:12
     ** (DBConnection.EncodeError) Postgrex expected a binary of 16 bytes, got "b3f587f6-d27c-4129-8e61-ef79911802a7". Please make sure the value you are passing matches the definition in your table or in your query or convert the value accordingly.
     code: permissions = Ecto.assoc(user, :permissions) |> Repo.all()
     stacktrace:
       (postgrex 0.15.9) lib/postgrex/type_module.ex:897: Postgrex.DefaultTypes.encode_params/3
       (postgrex 0.15.9) lib/postgrex/query.ex:75: DBConnection.Query.Postgrex.Query.encode/3
       (db_connection 2.4.0) lib/db_connection.ex:1205: DBConnection.encode/5
       (db_connection 2.4.0) lib/db_connection.ex:1305: DBConnection.run_prepare_execute/5
       (db_connection 2.4.0) lib/db_connection.ex:1409: DBConnection.run/6
       (db_connection 2.4.0) lib/db_connection.ex:574: DBConnection.parsed_prepare_execute/5
       (db_connection 2.4.0) lib/db_connection.ex:566: DBConnection.prepare_execute/4
       (ecto_sql 3.6.2) lib/ecto/adapters/sql.ex:701: Ecto.Adapters.SQL.execute!/4
       (ecto_sql 3.6.2) lib/ecto/adapters/sql.ex:693: Ecto.Adapters.SQL.execute/5
       (ecto 3.6.2) lib/ecto/repo/queryable.ex:224: Ecto.Repo.Queryable.execute/4
       (ecto 3.6.2) lib/ecto/repo/queryable.ex:19: Ecto.Repo.Queryable.all/3
       test/example_test.exs:14: (test)
```

We can manually resolve the error by forcing the casting like this:

```
user
|> Map.put(:id, Ecto.UUID.dump!(user.id))
|> Ecto.assoc(:permissions)
|> Repo.all()
```

But is there a configuration which can resolve this issue?


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `example` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:example, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/example](https://hexdocs.pm/example).

