local M = {}

local icons  = require('rabbitline.icons')

local provider = function(highlight, icon, condition)
  if type(highlight) == 'string' and highlight:sub(1, 1) == '#' then
    highlight = {nil, highlight}
  end
  return {
    highlight = highlight,
    provider = icon,
    condition = condition
  }
end

M.left = function(highlight, condition)
  return provider(highlight, icons.bubble_left, condition)
end

M.right = function(highlight, condition)
  return provider(highlight, icons.bubble_right, condition)
end

return M
