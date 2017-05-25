defmodule RealWorld.Blog.Comment do
  use Ecto.Schema

  schema "blog_comments" do
    field :body, :string
    field :user_id, :id
    field :article_id, :id
    belongs_to :article, RealWorld.Blog.Article
    
    timestamps()
  end
end
