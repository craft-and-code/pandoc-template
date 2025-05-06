function BlockQuote(el)
  if #el.content > 0 and el.content[1].t == "Para" then
    local para = el.content[1]
    if #para.content > 1 and para.content[1].t == "Image" then
      local img = para.content[1]

      -- Associates images with box styles
      local alert_types = {
        ["note"] = {"notecolor", "note"},
        ["lightbulb"] = {"tipcolor", "lightbulb"},
        ["important"] = {"importantcolor", "important"},
        ["warning"] = {"warningcolor", "warning"},
        ["fire"] = {"cautioncolor", "fire"}
      }

      local alert_data = alert_types[img.src:match("[^/]+$"):gsub("%.svg$", "")]
      if alert_data then
        local color, icon = alert_data[1], alert_data[2]

        -- Direct conversion to LaTeX
        local latex_writer = {
          Str = function(s)
            local text = s.text
            -- Handle quotation marks with LaTeX quotes
            if text:match('"') then
              text = text:gsub('"(.+)"', '\\enquote{%1}')
            end
            return text
          end,
          Space = function() return " " end,
          Code = function(s)
            local text = s.text:gsub("([%$%_%{%}%&%#])", "\\%1")
                               :gsub("%^", "\\string^")
            return "\\texttt{" .. text .. "}"
          end,
          Link = function(s)
            if s.target:match("^#") then
              return "\\hyperref[" .. s.target:sub(2) .. "]{" .. process_inlines(s.content) .. "}"
            end
            return "\\href{" .. s.target .. "}{" .. process_inlines(s.content) .. "}"
          end,
          Emph = function(s) return "\\emph{" .. process_inlines(s.content) .. "}" end,
          Strong = function(s) return "\\textbf{" .. process_inlines(s.content) .. "}" end,
          BulletList = function(s)
            local items = {}
            for _, item in ipairs(s) do
              table.insert(items, "\\item " .. process_inlines(item[1].content))
            end
            return "\\begin{itemize}" .. table.concat(items) .. "\\end{itemize}"
          end,
          Para = function(s)
            local content = process_inlines(s.content)
            return content ~= "" and (content .. "\\par") or ""
          end,
          Plain = function(s) return process_inlines(s.content) end,
          LineBreak = function() return "\\par " end,
          SoftBreak = function() return " " end,
          OrderedList = function(s)
            local items = {}
            for _, item in ipairs(s) do
              if item[1] and item[1].content then
                local item_content = process_inlines(item[1].content)
                if item_content:match("^%s*$") then
                  item_content = "~"
                end
                table.insert(items, "\\item " .. item_content)
              end
            end
            return "\\par\\vspace{0.5em}\\begin{enumerate}\n" .. table.concat(items, "\n") .. "\n\\end{enumerate}\\par"
          end,
          CodeBlock = function(s)
            -- Same processing for code blocks
            local escaped_text = s.text:gsub("([%$%_%{%}%&%#%^])", "\\%1")
            return "\\begin{tcolorbox}[colback=gray!10,boxrule=0pt,arc=4pt]\n" .. escaped_text .. "\n\\end{tcolorbox}"
          end
        }

        process_inlines = function(content)
          local result = {}
          for _, elem in ipairs(content) do
            if latex_writer[elem.t] then
              table.insert(result, latex_writer[elem.t](elem))
            end
          end
          return table.concat(result)
        end


        -- Get initial content and additional blocks
        local content_blocks = {}

        -- Add first paragraph content (after image)
        local first_content = {}
        for i = 2, #para.content do
          table.insert(first_content, para.content[i])
        end

        -- Process content
        local initial_content = process_inlines(first_content)
        if initial_content ~= "" then
          table.insert(content_blocks, initial_content)
        end

        -- Add remaining blocks
        if #el.content > 1 then
          for i = 2, #el.content do
            local block = el.content[i]
            if latex_writer[block.t] then
              local block_content = latex_writer[block.t](block)
              if block_content ~= "" then
                table.insert(content_blocks, block_content)
              end
            end
          end
        end

        local message = table.concat(content_blocks, "\n")

        local content = {
          pandoc.RawBlock(
            "latex",
            string.format(
              "\\begin{alertblock}{%s}{assets/icons/%s}%s\\end{alertblock}",
              color,
              icon,
              message
            )
          )
        }

        return content
      end
    end
  end
end
