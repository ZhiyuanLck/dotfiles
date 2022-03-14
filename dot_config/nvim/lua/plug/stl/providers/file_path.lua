local cmd    = vim.cmd
local bo     = vim.bo
local fn     = vim.fn
local u      = require('plug.stl.utils')
local colors = require('plug.stl.colors').file_path
local icons  = require('plug.stl.icons').file_path
local f      = require('galaxyline.provider_fileinfo')
local c      = require('galaxyline.condition')
local vcs    = require('galaxyline.provider_vcs')

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

-- file name provider
local function get_file_name()
  -- not work
  -- local is_active = vim.g.statusline_winid == fn.win_getid(fn.winnr())
  local is_active = true
  local normal_fg = is_active and colors.active or colors.inactive
  local modified_fg = is_active and colors.active_m or colors.inactive_m

  if bo.modifiable then
    cmd(('hi GalaxyFileName guibg=%s guifg=%s gui=%s'):format(colors.file_bg,
      unpack(bo.modified and {modified_fg, 'bold'} or {normal_fg, 'NONE'})))
  end

  local fname = f.get_current_file_name(icons.modified, icons.read_only)

  if c.check_git_workspace() and checkwidth() then
    local git_dir = vcs.get_git_dir(fn.expand("%:p"))
    local current_dir = fn.expand("%:p:h")
    if git_dir and git_dir ~= current_dir then
      fname = current_dir:sub(#git_dir - 3) .. '/' .. fname
    end
  end

  local name = fn.expand('%:p:t')
  local ext = fn.expand('%:p:e')
  local icon = require('nvim-web-devicons').get_icon(name, ext, {default = true})

  return icon .. ' ' .. fname
end

local function file_name()
  return {
    highlight = 'GalaxyFileName',
    condition = u.buffer_not_empty,
    provider = function() return get_file_name() end
  }
end

cmd('hi GalaxyFileInv guifg=' .. colors.file_bg)

u.insert(1, u.bracket(1, 'GalaxyModeInvR', u.buffer_not_empty))
u.insert(1, file_name())
u.insert(1, u.bracket(2, 'GalaxyFileInv', u.buffer_not_empty))
