local cmd = vim.cmd
local fmt = string.format

local Section = {}

Section.__index = Section

local sec_id = 0

-- create a new section
-- @param opts table: options
-- @field provider string or function: section text (default '')
--   string: section text
--   function: return section text
-- @field highlight string or table or function: section highlight (default 'StatusLine')
--   string: highlight group name
--   table: highlight specification
--   function: return highlight group name
-- @field end_hl string or table or function: section end highlight (default 'Normal')
--   string: highlight group name
--   table: highlight specification
--   function: return highlight group name
-- @field line_name string: name of the line (require value)
-- @field sec_name string: name of the section (default 'Sec' .. sec_id)
function Section:new(opts)
  opts = opts or {}
  if not opts.line_name then
    error('field line_name is required')
  end
  if not opts.sec_name then
    opts.sec_name = 'Sec' .. sec_id
    sec_id = sec_id + 1
  end

  -- convenient function to generate an string that can identify the current section
  local _fmt = function(str)
    return string.format(str, opts.line_name, opts.sec_name)
  end

  -- provider
  local provider = opts.provider or ''
  if type(provider) == 'string' then
    local text = provider
    provider   = function() return text end
  end

  -- highlight
  local highlight = opts.highlight or 'StatusLine'
  if type(highlight) == 'table' then
    local bg = highlight[1] and 'guibg=' .. highlight[1] or ''
    local fg = highlight[2] and 'guifg=' .. highlight[2] or ''
    local gui = #highlight == 3 and 'gui=' .. highlight[3] or ''
    highlight = function()
      local hl_group = _fmt('TblHl%s%s')
      cmd(fmt('hi %s %s %s %s', hl_group, bg, fg, gui))
      return hl_group
    end
  elseif type(highlight) == 'string' then
    local sec_hl = highlight
    highlight = function() return sec_hl end
  end

  -- end_highlight
  local end_hl = opts.end_hl or 'Normal'
  if type(end_hl) == 'table' then
    local bg = end_hl[1] and 'guibg=' .. end_hl[1] or ''
    local fg = end_hl[2] and 'guifg=' .. end_hl[2] or ''
    local gui = #end_hl == 3 and 'gui=' .. end_hl[3] or ''
    end_hl = function()
      local hl_group = _fmt('TblEndHl%s%s')
      cmd(fmt('hi %s %s %s %s', hl_group, bg, fg, gui))
      return hl_group
    end
  elseif type(end_hl) == 'string' then
    local sec_hl = end_hl
    end_hl = function() return sec_hl end
  end

  return setmetatable({
    condition = opts.condition or function() return true end,
    highlight = highlight,
    provider  = provider,
    end_hl    = end_hl,
  }, Section)
end

function Section:len()
  self.length = self.length or vim.api.nvim_strwidth(self.provider())
  return self.length
end

function Section:get_spec()
  if not self.condition() then
    self.length = 0
    return ''
  end
  local text = self.provider()
  self.length = vim.api.nvim_strwidth(text)
  text = text:gsub(' ', "\\u00a0")
  return fmt('%%#%s#%%{"%s"}%%#%s#', self.highlight(), text, self.end_hl())
end

return Section
