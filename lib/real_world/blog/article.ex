defmodule RealWorld.Blog.Article do
  @moduledoc """
  The Article Model
  """

  use Ecto.Schema

  schema "articles" do
    field :body, :string
    field :description, :string
    field :title, :string
    field :slug, :string
    field :favorited, :boolean, virtual: true
    belongs_to :author, RealWorld.Accounts.User, foreign_key: :user_id 
    has_many :comments, RealWorld.Blog.Comment
    many_to_many :likers, RealWorld.Accounts.User, join_through: RealWorld.ArticleFavorite

    timestamps inserted_at: :created_at
  end
end

defimpl Phoenix.Param, for: RealWorld.Blog.Article do
  def to_param(%{slug: slug}) do
    slug
  end
end
