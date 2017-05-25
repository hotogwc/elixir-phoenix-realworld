defmodule RealWorld.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string
      add :user_id, references(:users)
      add :article_id, references(:articles)

      timestamps inserted_at: :created_at
    end
  end
end
