defmodule RealWorld.Web.ArticleController do
  use RealWorld.Web, :controller
  use Guardian.Phoenix.Controller
  
  alias RealWorld.Blog
  alias RealWorld.Blog.Article

  action_fallback RealWorld.Web.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, %{handler: RealWorld.Web.SessionController} when action in [:create]

  def index(conn, _params, _, _) do
    articles = Blog.list_articles()
    render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params}, user, _) do
    with %Article{} = article <- Blog.create_article(article_params |> Map.merge(%{"user_id" => user.id})) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", article_path(conn, :show, article))
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"slug" => slug}, _, _) do
    article = Blog.get_article_by_slug! slug
    render(conn, "show.json", article: article)
  end

  def update(conn, %{"slug" => slug, "article" => article_params}, _, _) do
    article = Blog.get_article_by_slug! slug

    with {:ok, %Article{} = article} <- Blog.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  def delete(conn, %{"slug" => slug}, _, _) do
    article = Blog.get_article_by_slug! slug
    with {:ok, %Article{}} <- Blog.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end

  def favorite(conn, %{"article_slug" => slug}, user, _) do
    with {:ok, article} <- Blog.favorite_article_with_slug(slug, user) do
      conn
      |> put_status(:created)
      |> render("show.json", article: article)
    end
  end

  def unfavorite(conn, %{"article_slug" => slug}, user, _) do
    with {:ok, article} <- Blog.unfavorte_article_with_slug(slug, user) do
      conn
      |> put_status(200)
      |> render("show.json", article: article)
    end
  end
end
