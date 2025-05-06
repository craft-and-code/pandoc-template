function BlockQuote(el)
  if #el.content > 0 and el.content[1].t == "Para" then
    local para = el.content[1]
    if #para.content > 1 and para.content[1].t == "Image" then
      local img = para.content[1]
      local icon = img.src:match("[^/]+$"):gsub("%.svg$", "")

      -- Create icon container
      local icon_div = pandoc.Div(
        {pandoc.Plain({img})},
        pandoc.Attr("", {"alert-icon"})
      )

      -- Create content container without image
      local content = pandoc.List()

      -- Clean and add first paragraph (without image)
      local new_para_content = pandoc.List()
      for i = 2, #para.content do
        if para.content[i].t ~= "SoftBreak" then -- Ignore <br>
          table.insert(new_para_content, para.content[i])
        end
      end

      -- Add paragraph only if it has content
      if #new_para_content > 0 then
        table.insert(content, pandoc.Para(new_para_content))
      end

      -- Add all other blocks
      for i = 2, #el.content do
        table.insert(content, el.content[i])
      end

      -- Create content div
      local content_div = pandoc.Div(
        content,
        pandoc.Attr("", {"alert-content"})
      )

      -- Return blockquote with complete structure
      return pandoc.BlockQuote(
        {icon_div, content_div},
        pandoc.Attr("", {"alert-block", "alert-" .. icon}, {["data-type"] = icon})
      )
    end
  end
  return el
end
