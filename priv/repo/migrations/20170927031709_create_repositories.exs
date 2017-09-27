defmodule Githubware.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :full_name, :string
      add :html_url, :string
      add :description, :string
      add :language, :string
      add :stargazers_count, :integer
      add :watchers_count, :integer
      add :owner, :string
      add :github_id, :integer

      timestamps()
    end

  end
end
