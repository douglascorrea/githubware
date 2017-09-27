defmodule GithubwareWeb.PageController do
  use GithubwareWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
