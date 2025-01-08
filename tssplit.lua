local ts = {}

local function strStrip(s, chars)
  chars = chars or " \t\n\r"

  local i = 1
  local j = string.len(s)

  while i <= j do
    local c = string.sub(s, i, i)

    if not string.find(chars, c) then
      break
    end

    i = i + 1
  end

  while j >= i do
    local c = string.sub(s, j, j)

    if not string.find(chars, c) then
      break
    end

    j = j - 1
  end

  return string.sub(s, i, j)
end

function ts.split(s, options)
  local quote = options["quote"] or "\"'"
  local quoteKeep = options["quoteKeep"] or false
  local delimiter = options["delimiter"] or ":;,"
  local escape = options["escape"] or "/^"
  local trim = options["trim"] or ""
  local remark = options["remark"] or "#"

  local inQuotes = false
  local inEscape = false
  local token = ""
  local result = {}
  local sLen = string.len(s)

  for i = 1, sLen do
    local c = string.sub(s, i, i)

    if inEscape then
      token = token .. c
      inEscape = false
    elseif string.find(escape, c, 1, true) then
      inEscape = true

      if inQuotes then
        token = token .. c
      end
    elseif string.find(quote, c, 1, true) and not inEscape then
      inQuotes = not inQuotes

      if quoteKeep then
        token = token .. c
      end
    elseif string.find(delimiter, c, 1, true) and not inQuotes then
      if trim ~= "" then
        token = strStrip(token, trim)
      end

      table.insert(result, token)
      token = ""
    elseif string.find(remark, c, 1, true) then
      break
    else
      token = token .. c
    end
  end

  if trim ~= "" then
    token = strStrip(token, trim)
  end

  table.insert(result, token)
  return result
end

return ts
