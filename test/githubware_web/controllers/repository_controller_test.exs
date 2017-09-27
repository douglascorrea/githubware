defmodule GithubwareWeb.RepositoryControllerTest do
  use GithubwareWeb.ConnCase

  alias Githubware.Repositories

  @create_attrs %{description: "some description", full_name: "some full_name", html_url: "some html_url", language: "some language", owner: "some owner", stargazers_count: 42, watchers_count: 42}
  @update_attrs %{description: "some updated description", full_name: "some updated full_name", html_url: "some updated html_url", language: "some updated language", owner: "some updated owner", stargazers_count: 43, watchers_count: 43}
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

  describe "new repository" do
    test "renders form", %{conn: conn} do
      conn = get conn, repository_path(conn, :new)
      assert html_response(conn, 200) =~ "New Repository"
    end
  end

  describe "create repository" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, repository_path(conn, :create), repository: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == repository_path(conn, :show, id)

      conn = get conn, repository_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Repository"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, repository_path(conn, :create), repository: @invalid_attrs
      assert html_response(conn, 200) =~ "New Repository"
    end
  end

  describe "edit repository" do
    setup [:create_repository]

    test "renders form for editing chosen repository", %{conn: conn, repository: repository} do
      conn = get conn, repository_path(conn, :edit, repository)
      assert html_response(conn, 200) =~ "Edit Repository"
    end
  end

  describe "update repository" do
    setup [:create_repository]

    test "redirects when data is valid", %{conn: conn, repository: repository} do
      conn = put conn, repository_path(conn, :update, repository), repository: @update_attrs
      assert redirected_to(conn) == repository_path(conn, :show, repository)

      conn = get conn, repository_path(conn, :show, repository)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, repository: repository} do
      conn = put conn, repository_path(conn, :update, repository), repository: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Repository"
    end
  end

  describe "delete repository" do
    setup [:create_repository]

    test "deletes chosen repository", %{conn: conn, repository: repository} do
      conn = delete conn, repository_path(conn, :delete, repository)
      assert redirected_to(conn) == repository_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, repository_path(conn, :show, repository)
      end
    end
  end

  defp create_repository(_) do
    repository = fixture(:repository)
    {:ok, repository: repository}
  end
end
