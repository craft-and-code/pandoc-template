-- Emoji mapping table
local emoji_ranges = {
  {0x1F300, 0x1F9FF}, -- Emojis & Pictographs
  {0x2600, 0x26FF},   -- Misc Symbols
  {0x2700, 0x27BF},   -- Dingbats
  {0x1F600, 0x1F64F}, -- Emoticons
}

function is_emoji(char)
  -- Check if character is in emoji range
  local code = char:byte(1)
  if code >= 0x1F300 and code <= 0x1F9FF then
    return true
  end

  return false
end

function is_emoji_char(s)
  -- Unicode ranges table for emojis only
  local ranges = {
    {0x1F300, 0x1F9FF}, -- Extended Emojis
    {0x1F600, 0x1F64F}, -- Emoticons
    {0x1F680, 0x1F6FF}, -- Transport Symbols
    {0x2600, 0x26FF},   -- Miscellaneous Symbols
  }

  local code = s:byte(1)
  for _, range in ipairs(ranges) do
    if code >= range[1] and code <= range[2] then
      return true
    end
  end

  return false
end

function Str(elem)
  -- Process only real emojis
  if elem.text:match("[\xF0\x9F]") then
    return pandoc.RawInline('latex', string.format("{\\notoemojiSymbol %s}", elem.text))
  end

  return elem
end
