local M        = {}
local fn       = vim.fn
local gl       = require('galaxyline')
local gls      = gl.section
local brackets = require('plug.stl.icons').brackets

-- set default condtion otherwise return true
-- if ft not in tbl, return true
-- else if tbl[ft] is true, return false
-- else tbl[ft] is false, return true
function M.default_condition()
	local tbl = { [''] = true }
  return tbl[vim.bo.filetype] and false or true
end

-- always return true
function M.true_condition()
	return true
end

function M.buffer_not_empty()
  return fn.empty(fn.expand('%:t')) ~= 1
end

function M.buffer_empty()
  return fn.empty(fn.expand('%:t')) == 1
end

-- construct provider
-- @param text, string, block text
-- @param highlight, string, highlight group
-- @param condition, string
-- @return table of provider
local function get_provider(text, highlight, condition)
  condition = condition or true_condition
  return {
    highlight = highlight,
    condition = condition,
    provider  = function() return text end,
  }
end

-- bracket provider
-- @param pos, int, 1 for left, 2 for right
-- @param highlight, string, highlight group
-- @param condition, string
-- @return table of provider
function M.bracket(pos, highlight, condition)
  return get_provider(brackets[pos], highlight, condition)
end

-- blank provider
-- @param count, int, number of blanks
-- @param highlight, string, highlight group or hex color
-- @param condition, string
-- @return table of provider
function M.blank(count, highlight, condition)
  if string.find(highlight, '#%x{6}') then
    highlight = {highlight, highlight}
  end
  return get_provider(string.rep('a', count), highlight, condition)
end

local indices = {0, 0, 0}
local sections = {gls.left, gls.mid, gls.right}
local i = 0

function M.insert(pos, block)
  i = i + 1
  indices[pos] = indices[pos] + 1
  sections[pos][indices[pos]] = { ['TMP' .. i] = block}
end

return M
