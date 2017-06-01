defmodule RealWorld.Repo.Migrations.AddFavoriteTable do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :user_id, references(:users), primary_key: true
      add :article_id, references(:articles), primary_key: true
    end
  end
end
