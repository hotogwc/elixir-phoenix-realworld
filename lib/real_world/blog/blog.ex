defmodule RealWorld.Blog do
  @moduledoc """
  The boundary for the Blog system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias RealWorld.Repo

  alias RealWorld.Blog.{Article, Comment}

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Repo.all(Article) |> Repo.preload(:author)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id) |> Repo.preload(:author)


  @doc """
  Gets a single article with slug

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

  iex> get_article_by_slug!(how-to-train-your-dragon)
  %Article{}

  iex> get_article_by_slug!(how-to-train-your-dragon)
  ** (Ecto.NoResultsError)

  """
  def get_article_by_slug!(slug), do: Repo.get_by!(Article, slug: slug) |> Repo.preload(:author)

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> article_changeset(attrs)
    |> Repo.insert!()
    |> Repo.preload(:author)
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> article_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{source: %Article{}}

  """
  def change_article(%Article{} = article) do
    article_changeset(article, %{})
  end

  defp article_changeset(%Article{} = article, attrs) do
    article
    |> cast(attrs, [:title, :description, :body, :slug, :user_id])
    |> validate_required([:title, :description, :body])
    |> assoc_constraint(:author)
    |> slugify_title()
  end

  defp slugify_title(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, slugify(title))
    else
      changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end


  @doc """
  Returns the list comments of given slug of an article

  ## Examples

  iex> list_comments_for_article_slug! "how-to-train-your-dragon"
  [%Comment{}, ...]
  iex> list_comments_for_article_slug! "1111"
  ** (Ecto.NoResultsError)
  """
  def list_comments_for_article_slug!(slug) do
    article = Repo.get_by!(Article, slug: slug) |> Repo.preload(:comments)
    article.comments
  end


  def create_new_comments_for_article_slug(slug, attrs \\ %{}) do
    case Repo.get_by(Article, slug: slug) do
      article ->
        comment =
          article
          |> build_assoc(:comments)
          |> Comment.changeset(attrs)
          |> Repo.insert!()
          {:ok, comment}
      nil -> {:error, :not_found}
    end
  end

  def delete_comment(id) do
    comment = Repo.get! Comment, id
    Repo.delete(comment)
  end
end
