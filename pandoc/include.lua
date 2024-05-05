--[[ Source: https://gist.github.com/tarleb/1a690d38508d99c88c331f63ce7f6a2c ]]

local List = require 'pandoc.List'

function CodeBlock(cb)
  if cb.classes:includes 'include' then
    local blocks = List:new()
    for line in cb.text:gmatch('[^\n]+') do
      if line:sub(1,1) ~= '#' then
        local fh = io.open(line)
        blocks:extend(pandoc.read (fh:read '*a').blocks)
        fh:close()
      end
    end
    return blocks
  end
end