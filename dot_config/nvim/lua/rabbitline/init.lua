local M = { tabline = {}, stl = {} }
local fmt = string.format

local default_opts = {
  stl = {
    event = {
      'ColorScheme', 'FileType', 'BufWinEnter', 'BufReadPost', 'BufWritePost',
      'BufEnter', 'WinEnter', 'FileChangedShellPost', 'VimResized', 'TermOpen',
    },
  },
  tabline = {
    event = {'TabNewEntered', 'WinEnter', 'BufEnter'},
    colors = {
      active_bg = '#c37798',
      active_fg = '#000000',
      inactive_bg = '#474446',
      inactive_fg = '#ffffff',
    },
    empty_buf = '[EMPTY]',
    float_win = '[FLOAT]',
  }
}

function M.stl.set_autocommands()
  vim.cmd('aug RabbitLine')
  vim.cmd('au!')
  for _, event in ipairs(M.stl.event) do
    vim.cmd(([[au %s * lua require('rabbitline').stl.update_func()]]):format(event))
  end
  for _, event in ipairs(M.tabline.event) do
    vim.cmd(([[au %s * lua require('rabbitline.tabline').update()]]):format(event))
  end
  vim.cmd('aug END')
end

-- setup statusline
-- @param opts table
-- @field update_func function: function to update statusline (default nil)
-- @field event list: event list to update statusline (default default_opts.stl.update_event)
local function setup_statusline(opts)
  opts = opts or {}
  if type(opts.update_func) ~= 'function' then
    error('you must provide update function for statusline by opts.update_func')
  end
  M.stl.event = opts.event or default_opts.stl.event
  M.stl.update_func = opts.update_func
  M.stl.update_func()
end

local function setup_tabline(opts)
  opts = opts or {}
  M.tabline = opts.tabline or default_opts.tabline
  local c = M.tabline.colors
  vim.cmd(fmt('hi TabActive guibg=%s guifg=%s gui=bold', c.active_bg, c.active_fg))
  vim.cmd(fmt('hi TabInactive guibg=%s guifg=%s gui=bold', c.inactive_bg, c.inactive_fg))
  vim.cmd(fmt('hi TabActiveInv guifg=%s', c.active_bg))
  vim.cmd(fmt('hi TabInactiveInv guifg=%s', c.inactive_bg))
end

-- setup line
-- @param opts table: options
-- @field stl table: statusline options
-- @field tab table: tabline options
function M.setup(opts)
  opts = opts or {}
  setup_statusline(opts.stl)
  setup_tabline(opts.tabline)
end

return M
