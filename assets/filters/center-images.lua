function Image(elem)
  -- Don't process images that are already figures
  if elem.classes[1] ~= "figure" then
    -- Specific LaTeX format for centering
    if FORMAT:match 'latex' then
      return {
        pandoc.RawInline('latex', '\\begin{center}'),
        elem,
        pandoc.RawInline('latex', '\\end{center}')
      }
    end
    -- Add 'center' class for HTML output
    table.insert(elem.classes, "center")
    -- Add LaTeX attribute for centering
    elem.attributes["latex-center"] = "true"
  end
  return elem
end
