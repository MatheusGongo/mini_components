defmodule MiniComponents do

  import MiniComponents.{CSS, Attributes}
  import Phoenix.HTML, only: [html_escape: 1]
  import Phoenix.HTML.Form, only: [input_id: 2, input_name: 2, input_value: 2]


  def extend_class(assigns, default_classes, opts \\ []) do
    class_attribute_name = Keyword.get(opts, :attribute, :class)

    new_class =
      assigns
      |> css_extend_class(default_classes, class_attribute_name)

    assigns
    |> Map.put(:"#{class_attribute_name}", new_class)
    |> Map.put(:"prop_#{class_attribute_name}", {:safe, "class=#{escaped(new_class)}"})
  end

  def set_phx_attributes(assigns, opts \\ []) do
    opts = Keyword.put_new(opts, :into, :phx_attributes)
    set_prefixed_attributes(assigns, ["phx_"], opts)
  end

  def set_prefixed_attributes(assigns, prefixes, opts \\ []) do
    phx_attributes =
      prefixes
      |> Enum.flat_map(&find_assigns_with_prefix(assigns, &1))
      |> Enum.uniq()

    assigns
    |> do_set_attributes(phx_attributes, opts)
  end

  defp set_attribute_key(attr) do
    "prop_#{attr}" |> String.replace("@", "") |> String.to_atom()
  end

  defp escaped(val) do
    {:safe, escaped_val} = html_escape(val)
    "\"#{escaped_val}\""
  end

  defp find_assigns_with_prefix(assigns, prefix) do
    for key <- Map.keys(assigns),
        key_s = to_string(key),
        String.starts_with?(key_s, prefix),
        do: key
  end

end
