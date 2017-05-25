defmodule RealWorld.Web.CommentController do
  use RealWorld.Web, :controller
  use Guardian.Phoenix.Controller

  alias RealWorld.Blog
  alias RealWorld.Blog.{Article, Comment}

  action_fallback RealWorld.Web.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, %{handler: RealWorld.Web.SessionController} when action in [:create, :delete]


  def create(conn, _, _, _) do
    
  end

  def index(conn, _, _, _) do
    
  end

  def delete(conn, _, _, _) do
    
  end
end
