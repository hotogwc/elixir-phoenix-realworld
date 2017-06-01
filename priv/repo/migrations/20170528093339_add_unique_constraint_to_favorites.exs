defmodule RealWorld.Repo.Migrations.AddUniqueConstraintToFavorites do
  use Ecto.Migration

  def change do
    create unique_index(:favorites, [:user_id, :article_id])
  end
end
