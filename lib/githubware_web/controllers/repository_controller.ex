defmodule GithubwareWeb.RepositoryController do
  use GithubwareWeb, :controller

  alias Githubware.Repositories
  alias Githubware.Repositories.Repository

  def index(conn, _params) do
    repositories = Repositories.list_repositories()
    render(conn, "index.html", repositories: repositories)
  end

  def new(conn, _params) do
    changeset = Repositories.change_repository(%Repository{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"repository" => repository_params}) do
    case Repositories.create_repository(repository_params) do
      {:ok, repository} ->
        conn
        |> put_flash(:info, "Repository created successfully.")
        |> redirect(to: repository_path(conn, :show, repository))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    repository = Repositories.get_repository!(id)
    render(conn, "show.html", repository: repository)
  end

  def edit(conn, %{"id" => id}) do
    repository = Repositories.get_repository!(id)
    changeset = Repositories.change_repository(repository)
    render(conn, "edit.html", repository: repository, changeset: changeset)
  end

  def update(conn, %{"id" => id, "repository" => repository_params}) do
    repository = Repositories.get_repository!(id)

    case Repositories.update_repository(repository, repository_params) do
      {:ok, repository} ->
        conn
        |> put_flash(:info, "Repository updated successfully.")
        |> redirect(to: repository_path(conn, :show, repository))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", repository: repository, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    repository = Repositories.get_repository!(id)
    {:ok, _repository} = Repositories.delete_repository(repository)

    conn
    |> put_flash(:info, "Repository deleted successfully.")
    |> redirect(to: repository_path(conn, :index))
  end
end
