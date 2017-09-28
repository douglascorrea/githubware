defmodule Githubware.Repositories do
  @moduledoc """
  The Repositories context.
  """

  import Ecto.Query, warn: false
  alias Githubware.Repo

  alias Githubware.Repositories.Repository

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repository{}, ...]

  """
  def list_repositories(lang) do
    Repo.all(
      Repository
      |> where(language: ^lang)
      |> limit(5)
      |> order_by(desc: :stargazers_count)
    )
  end

  @doc """
  Gets a single repository by github id
  """
  def get_repository_by_github_id(github_id), do: Repo.get_by(Repository, github_id: github_id)

  @doc """
  Gets a single repository.

  Raises `Ecto.NoResultsError` if the Repository does not exist.

  ## Examples

      iex> get_repository!(123)
      %Repository{}

      iex> get_repository!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repository!(id), do: Repo.get!(Repository, id)

  @doc """
  Creates or Updates a repository.

  ## Examples

      iex> update_repository(repository, %{field: new_value})
      {:ok, %Repository{}}

      iex> update_repository(repository, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_or_update_repository(repository) do
    case get_repository_by_github_id(repository["id"]) do
      nil ->
        repository_to_insert = %Repository{}
                               |> Repository.changeset(repository)
                               |> Repo.insert()

      repo_found ->
        repo_found
        |> Repository.changeset(repository)
        |> Repo.update()

    end

  end

end
