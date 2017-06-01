defmodule RealWorld.ArticleFavorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorites" do
    field :user_id, :integer, primary_key: true
    field :article_id, :integer, primary_key: true
  end

  def changeset(favorite, attrs \\ %{}) do
    favorite
    |> cast(attrs, [:user_id, :article_id])
    |> validate_required([:user_id, :article_id])
    |> unique_constraint(:favorites, name: :favorites_user_id_article_id_index)
    |> foreign_key_constraint(:user_id)
  end
end
