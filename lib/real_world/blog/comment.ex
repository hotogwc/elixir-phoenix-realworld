defmodule RealWorld.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    belongs_to :article, RealWorld.Blog.Article
    belongs_to :author, RealWorld.Accounts.User, foreign_key: :user_id
    timestamps inserted_at: :created_at
  end

  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:body, :user_id, :article_id])
    |> validate_required([:body])
  end
end
