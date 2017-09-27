defmodule Githubware.RepositoriesTest do
  use Githubware.DataCase

  alias Githubware.Repositories

  describe "repositories" do
    alias Githubware.Repositories.Repository

    @valid_attrs %{description: "some description", full_name: "some full_name", html_url: "some html_url", language: "some language", owner: "some owner", stargazers_count: 42, watchers_count: 42}
    @update_attrs %{description: "some updated description", full_name: "some updated full_name", html_url: "some updated html_url", language: "some updated language", owner: "some updated owner", stargazers_count: 43, watchers_count: 43}
    @invalid_attrs %{description: nil, full_name: nil, html_url: nil, language: nil, owner: nil, stargazers_count: nil, watchers_count: nil}

    def repository_fixture(attrs \\ %{}) do
      {:ok, repository} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Repositories.create_repository()

      repository
    end

    test "list_repositories/0 returns all repositories" do
      repository = repository_fixture()
      assert Repositories.list_repositories() == [repository]
    end

    test "get_repository!/1 returns the repository with given id" do
      repository = repository_fixture()
      assert Repositories.get_repository!(repository.id) == repository
    end

    test "create_repository/1 with valid data creates a repository" do
      assert {:ok, %Repository{} = repository} = Repositories.create_repository(@valid_attrs)
      assert repository.description == "some description"
      assert repository.full_name == "some full_name"
      assert repository.html_url == "some html_url"
      assert repository.language == "some language"
      assert repository.owner == "some owner"
      assert repository.stargazers_count == 42
      assert repository.watchers_count == 42
    end

    test "create_repository/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Repositories.create_repository(@invalid_attrs)
    end

    test "update_repository/2 with valid data updates the repository" do
      repository = repository_fixture()
      assert {:ok, repository} = Repositories.update_repository(repository, @update_attrs)
      assert %Repository{} = repository
      assert repository.description == "some updated description"
      assert repository.full_name == "some updated full_name"
      assert repository.html_url == "some updated html_url"
      assert repository.language == "some updated language"
      assert repository.owner == "some updated owner"
      assert repository.stargazers_count == 43
      assert repository.watchers_count == 43
    end

    test "update_repository/2 with invalid data returns error changeset" do
      repository = repository_fixture()
      assert {:error, %Ecto.Changeset{}} = Repositories.update_repository(repository, @invalid_attrs)
      assert repository == Repositories.get_repository!(repository.id)
    end

    test "delete_repository/1 deletes the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{}} = Repositories.delete_repository(repository)
      assert_raise Ecto.NoResultsError, fn -> Repositories.get_repository!(repository.id) end
    end

    test "change_repository/1 returns a repository changeset" do
      repository = repository_fixture()
      assert %Ecto.Changeset{} = Repositories.change_repository(repository)
    end
  end
end
