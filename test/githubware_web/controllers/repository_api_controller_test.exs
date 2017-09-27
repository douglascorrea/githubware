defmodule GithubwareWeb.RepositoryApiControllerTest do
  use GithubwareWeb.ConnCase

  alias Githubware.Repositories
  alias Githubware.Repositories.RepositoryApi

  @create_attrs %{full_name: "some full_name"}
  @update_attrs %{full_name: "some updated full_name"}
  @invalid_attrs %{full_name: nil}

  def fixture(:repository_api) do
    {:ok, repository_api} = Repositories.create_repository_api(@create_attrs)
    repository_api
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all repository", %{conn: conn} do
      conn = get conn, repository_api_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create repository_api" do
    test "renders repository_api when data is valid", %{conn: conn} do
      conn = post conn, repository_api_path(conn, :create), repository_api: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, repository_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "full_name" => "some full_name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, repository_api_path(conn, :create), repository_api: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update repository_api" do
    setup [:create_repository_api]

    test "renders repository_api when data is valid", %{conn: conn, repository_api: %RepositoryApi{id: id} = repository_api} do
      conn = put conn, repository_api_path(conn, :update, repository_api), repository_api: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, repository_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "full_name" => "some updated full_name"}
    end

    test "renders errors when data is invalid", %{conn: conn, repository_api: repository_api} do
      conn = put conn, repository_api_path(conn, :update, repository_api), repository_api: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete repository_api" do
    setup [:create_repository_api]

    test "deletes chosen repository_api", %{conn: conn, repository_api: repository_api} do
      conn = delete conn, repository_api_path(conn, :delete, repository_api)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, repository_api_path(conn, :show, repository_api)
      end
    end
  end

  defp create_repository_api(_) do
    repository_api = fixture(:repository_api)
    {:ok, repository_api: repository_api}
  end
end
