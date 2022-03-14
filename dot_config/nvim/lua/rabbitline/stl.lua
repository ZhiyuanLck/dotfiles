local cmd = vim.cmd
local fmt = string.format

local Section = require('rabbitline.section')

local Line = {}

Line.__index = Line

local line_id = 0

-- create a new statusline object
-- @return table: Line object
function Line:new()
  local obj = {
    groups = {},
    name   = 'Line' .. line_id,
    used   = 0
  }
  line_id = line_id + 1
  setmetatable(obj, Line)

  Line[obj.name] = function()
    return obj:get_spec()
  end

  return obj
end

-- create a new group
-- @param secs list: section specifications
function Line:new_group(secs)
  local group = {}
  for _, opts in ipairs(secs) do
    opts = opts or {}
    opts.line_name = self.name
    table.insert(group, Section:new(opts))
  end
  table.insert(self.groups, group)
end

-- return statusline specification
function Line:get_spec()
  self.used = 0
  local parts = {}
  for _, group in ipairs(self.groups) do
    local part = ''
    for _, sec in ipairs(group) do
      part = part .. sec:get_spec()
      self.used = self.used + sec:len()
    end
    table.insert(parts, part)
  end
  return table.concat(parts, '%=')
end

function Line:rest()
  local total = vim.api.nvim_win_get_width(vim.g.statusline_winid)
  return total - self.used
end

function Line:update()
  vim.wo.stl = fmt([[%%!v:lua.require('rabbitline.stl').%s()]], self.name)
end

return Line
