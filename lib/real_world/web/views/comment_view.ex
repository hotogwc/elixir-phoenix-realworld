defmodule RealWorld.Web.CommentView do
  use RealWorld.Web, :view
  alias RealWorld.Web.{CommentView, FormatHelpers}
  def render("index.json", %{comments: comments}) do
    %{comments: render_many(comments, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    comment
    |> Map.from_struct
    |> Map.put(:created_at, NaiveDateTime.to_iso8601(comment.created_at))
    |> Map.put(:updated_at, NaiveDateTime.to_iso8601(comment.updated_at))
    |> Map.take([:id, :body, :created_at, :updated_at])
    |> FormatHelpers.camelize
  end
end
