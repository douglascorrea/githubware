defmodule GithubwareWeb.RepositoryControllerTest do
  use GithubwareWeb.ConnCase

  alias Githubware.Repositories

  @valid_attrs %{"description" => "some description", "full_name" => "some full_name", "html_url" => "some html_url", "language" => "some language", "stargazers_count" => 42, "watchers_count" => 42, "id" => 1231}
  @create_attrs %{"description" => "some description", "full_name" => "some full_name", "html_url" => "some html_url", "language" => "some language", "stargazers_count" => 43, "watchers_count" => 43, "id" => 1231}
  @invalid_attrs %{description: nil, full_name: nil, html_url: nil, language: nil, owner: nil, stargazers_count: nil, watchers_count: nil}

  def fixture(:repository) do
    {:ok, repository} = Repositories.create_repository(@create_attrs)
    repository
  end

  describe "index" do
    test "lists all repositories", %{conn: conn} do
      conn = get conn, repository_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Repositories"
    end
  end

end
