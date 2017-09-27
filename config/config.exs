# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :githubware,
  ecto_repos: [Githubware.Repo]

# Configures the endpoint
config :githubware, GithubwareWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vMYS8ZQap91mOhF4TDpmVnC2e/cNh7eBJNOygX4BU8qNNrb90PWZhDlP1YEa4Bp0",
  render_errors: [view: GithubwareWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Githubware.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
