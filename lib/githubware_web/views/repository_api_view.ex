defmodule GithubwareWeb.RepositoryApiView do
  use GithubwareWeb, :view
  alias GithubwareWeb.RepositoryApiView

  def render("index.json", %{repository: repository}) do
    %{data: render_many(repository, RepositoryApiView, "repository_api.json")}
  end

  def render("show.json", %{repository_api: repository_api}) do
    %{data: render_one(repository_api, RepositoryApiView, "repository_api.json")}
  end

  def render("repository_api.json", %{repository_api: repository_api}) do
    %{id: repository_api.id,
      full_name: repository_api.full_name}
  end
end
