defmodule MiniView do
  @moduledoc """
  MiniComponents keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  import MiniComponents.CSS

  def extend_form_class(options, default_classes) do
    extended_classes = css_extend_class(options, default_classes, :class)
    Keyword.put(options, :class, extended_classes)
  end
end
