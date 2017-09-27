defmodule GithubwareWeb.RepositoryApiController do
  use GithubwareWeb, :controller
  alias Githubware.Repositories
  alias Githubware.Repositories.RepositoryApi

  action_fallback GithubwareWeb.FallbackController

  def index(conn, _params) do
    client = Tentacat.Client.new
    repositories =
      Tentacat.Search.repositories(%{q: "language:elixir stars:>1000", sort: "stars"}, client)
      |> Map.get("items")
      |> Enum.take(5)

    Enum.each repositories, fn(rep) -> Repositories.create_or_update_repository(rep) end

    repositories = Repositories.list_repositories()

    render(conn, "index.json", repository: repositories)
  end

  def show(conn, %{"id" => id}) do
    repository_api = Repositories.get_repository_api!(id)
    render(conn, "show.json", repository_api: repository_api)
  end

end
