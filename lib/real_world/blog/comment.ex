defmodule RealWorld.Blog.Comment do
  use Ecto.Schema

  schema "comments" do
    field :body, :string
    belongs_to :article, RealWorld.Blog.Article
    belongs_to :author, RealWorld.Accounts.User, foreign_key: :user_id
    timestamps inserted_at: :created_at
  end
end
