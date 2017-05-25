defmodule RealWorld.Repo.Migrations.CreateRealWorld.Blog.Comment do
  use Ecto.Migration

  def change do
    create table(:blog_comments) do
      add :body, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :article_id, references(:articles, on_delete: :nothing)

      timestamps()
    end

    create index(:blog_comments, [:user_id])
    create index(:blog_comments, [:article_id])
  end
end
