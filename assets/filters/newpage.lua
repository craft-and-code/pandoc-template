function Para(elem)
  -- Check if paragraph contains only "+++"
  if #elem.content == 1 and elem.content[1].t == "Str" and elem.content[1].text == "+++" then
    return pandoc.RawBlock("latex", "\\newpage")
  end
end
