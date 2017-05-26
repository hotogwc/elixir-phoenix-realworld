defmodule RealWorld.Web.CommentController do
  use RealWorld.Web, :controller
  use Guardian.Phoenix.Controller

  alias RealWorld.Blog
  alias RealWorld.Blog.{Article, Comment}

  action_fallback RealWorld.Web.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, %{handler: RealWorld.Web.SessionController} when action in [:create, :delete]


  def create(conn, %{"article_slug" => slug, "comment" => comment_param}, _, _) do
    with {:ok, comment} <- Blog.create_new_comments_for_article_slug(slug, comment_param) do
      render(conn, "comment.json", comment: comment)
    end
  end

  def index(conn, %{"article_slug" => slug}, _, _) do
    comments = Blog.list_comments_for_article_slug! slug
    render(conn, "index.json", comments: comments)
  end

  def delete(conn, _, _, _) do
    
  end
end
