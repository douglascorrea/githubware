defmodule Githubware.Repositories.Repository do
  use Ecto.Schema
  import Ecto.Changeset
  alias Githubware.Repositories.Repository


  schema "repositories" do
    field :description, :string
    field :full_name, :string
    field :html_url, :string
    field :language, :string
    field :owner, :string
    field :stargazers_count, :integer
    field :watchers_count, :integer
    field :github_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Repository{} = repository, attrs) do
    attrs = for {key, val} <- attrs, into: %{}, do: {String.to_atom(key), val}
    attrs =
    attrs
    |> Map.update!(:owner,&(&1[:owner]["login"]))
    |> Map.update(:github_id,attrs[:id], &(&1[:id]))


    repository
    |> cast(attrs, [:full_name, :html_url, :github_id, :description, :language, :stargazers_count, :watchers_count, :owner])
  end
end
