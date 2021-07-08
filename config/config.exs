import Config

config :example, ecto_repos: [Repo]

config :example, Repo,
  database: "example_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 2
