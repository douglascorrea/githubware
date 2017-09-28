defmodule GithubwareWeb.RepositoryController do
  use GithubwareWeb, :controller

  alias Githubware.Repositories
  alias Githubware.Repositories.Repository

  def index(conn, _params) do
    render(conn, "index.html", repositories: [])
  end

  def list_lang_repositories(conn, %{"lang" => lang}) do
    client = Tentacat.Client.new

    repositories =
      case Tentacat.Search.repositories(%{q: "language:#{lang} stars:>1000", sort: "stars"}, client) do
        %{"items" => items} ->
          Enum.take(items, 5)
        items when is_list(items) ->
          items
          |> Enum.at(0)
          |> Map.get("items")
          |> Enum.take(5)
        _ ->
          []
      end

    Enum.each repositories, fn (rep) -> Repositories.create_or_update_repository(rep) end
    repositories = Repositories.list_repositories(String.capitalize(lang))

    render(conn, "index.html", repositories: repositories, lang: lang)
  end

  def show(conn, %{"id" => id, "lang" => lang}) do
    repository = Repositories.get_repository!(id)
    render(conn, "show.html", repository: repository, lang: lang)
  end

end
