defmodule Githubware.RepositoriesTest do
  use Githubware.DataCase

  alias Githubware.Repositories

  describe "repositories" do
    alias Githubware.Repositories.Repository

    @valid_attrs %{"description" => "some description", "full_name" => "some full_name", "html_url" => "some html_url", "language" => "Elixir", "owner" => [%{"login" => "login"}], "stargazers_count" => 42, "watchers_count" => 42, "id" => 42}
    @update_attrs %{"description" => "some updated description", "full_name" => "some updated full_name", "html_url" => "some updated html_url", "language" => "Elixir", "owner" => [%{"login" => "updatedlogin"}], "stargazers_count" => 43, "watchers_count" => 43, "id" => 43}
    @invalid_attrs %{description: nil, full_name: nil, html_url: nil, language: nil, owner: nil, stargazers_count: nil, watchers_count: nil}

    def repository_fixture(attrs \\ %{}) do
      {:ok, repository} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Repositories.create_or_update_repository()

      repository
    end

    test "list_repositories/0 returns all repositories" do
      repository = repository_fixture()
      assert Repositories.list_repositories("Elixir") == [repository]
    end

    test "get_repository!/1 returns the repository with given id" do
      repository = repository_fixture()
      assert Repositories.get_repository!(repository.id) == repository
    end

    test "create_or_update_repository/1 with valid data creates a repository" do
      assert {:ok, %Repository{} = repository} = Repositories.create_or_update_repository(@valid_attrs)
      assert repository.description == "some description"
      assert repository.full_name == "some full_name"
      assert repository.html_url == "some html_url"
      assert repository.language == "Elixir"
      assert repository.stargazers_count == 42
      assert repository.watchers_count == 42
      assert repository.github_id == 42
    end

    test "create_or_update_repository/2 with valid data updates the repository" do
      repository = repository_fixture()
      assert {:ok, repository} = Repositories.create_or_update_repository(@update_attrs)
      assert %Repository{} = repository
      assert repository.description == "some updated description"
      assert repository.full_name == "some updated full_name"
      assert repository.html_url == "some updated html_url"
      assert repository.language == "Elixir"
      assert repository.stargazers_count == 43
      assert repository.watchers_count == 43
      assert repository.github_id == 43
    end

  end
end
