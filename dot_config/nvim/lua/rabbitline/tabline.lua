local M = {}
local fn = vim.fn
local cmd = vim.cmd
local api = vim.api
local fmt = string.format
local icons = require('rabbitline.icons')
local conf = require('rabbitline').tabline

local path_sep = (function()
  if jit then
    local os = string.lower(jit.os)
    if os == "linux" or os == "osx" or os == "bsd" then
      return "/"
    else
      return "\\"
    end
  else
    return package.config:sub(1, 1)
  end
end)()

local get_path_parts = function(path)
  local parts = {}
  local pattern = fmt('[^%s]+', path_sep)
  for str in path:gmatch(pattern) do
    table.insert(parts, 1, str)
  end
  return parts
end

local Tab = {}

Tab.__index = Tab

function Tab:get_sep(sep)
  self.len = self.len + #sep
  local hl = self.active and 'TabActiveInv' or 'TabInactiveInv'
  return fmt('%%#%s#%%{"%s"}%%#Normal#', hl, sep)
end

function Tab:get_icon()
  if self.hide_icon then return '' end
  local ext = self.name:match("^.+%.(.+)$") or ''
  local icon = require('nvim-web-devicons').get_icon(self.name, ext, {default = true})
  return icon .. ' '
end

function Tab:get_section()
  local hl = self.active and 'TabActive' or 'TabInactive'
  local left = self:get_sep(icons.bubble_left)
  local icon = self:get_icon()
  local title = fmt(' %d %s%s ', self.tabnr, icon, self.name)
  self.len = self.len + #title
  local title_fmt = fmt('%%#%s#%%%dT%s%%T%%#Normal#', hl, self.tabnr, title)
  local right = self:get_sep(icons.bubble_right)
  return left .. title_fmt .. right
end

local Tabline = {}

Tabline.__index = Tabline

function Tabline:new()
  local obj = setmetatable({}, Tabline)
  obj:init()
  return obj
end

-- set info of every tab
function Tabline:init()
  local tabs = vim.api.nvim_list_tabpages()
  local cur_tab = vim.api.nvim_win_get_tabpage(0)
  local buf_map = {}
  local tabnrs = {}
  for tabnr, tabid in ipairs(tabs) do
    local winid = vim.api.nvim_tabpage_get_win(tabid)
    local bufid = vim.api.nvim_win_get_buf(winid)
    local bufname = vim.api.nvim_buf_get_name(bufid)

    -- respect empty buffer and float window
    local empty_buf = bufname == ''
    local float_win = vim.api.nvim_win_get_config(winid).relative ~= ''
    bufname = empty_buf and conf.empty_buf or bufname
    bufname = float_win and conf.float_win or bufname

    local parts = get_path_parts(bufname)
    local link
    if buf_map[bufid] == nil then
      buf_map[bufid] = tabnr
      link = tabnr
      table.insert(tabnrs, tabnr)
    else
      link = buf_map[bufid]
    end

    table.insert(self, setmetatable({
      cur       = 0,
      len       = 0,
      link      = link,
      tabnr     = tabnr,
      parts     = parts,
      parts_len = #parts,
      active    = cur_tab == tabid,
      hide_icon = empty_buf or float_win,
    }, Tab))
  end
  self:set_tab_names(tabnrs)
  for _, tab in ipairs(self) do
    tab.name = self[tab.link].name
  end
end

-- set tab name
-- @param tab table
-- @field parts table: path parts
-- @field active boolean: state of tab
-- @field bufid number: buffer handle
-- @field cur number: parts index, parts[1, cur] will be used to set the tab name
function Tabline:set_name(tab)
  local parts = {}
  -- in case there are all same buffer
  if tab.cur == 0 then tab.cur = 1 end
  for i = 1, tab.cur do table.insert(parts, 1, tab.parts[i]) end
  tab.name = table.concat(parts, path_sep)
end

-- make each tab name unique. In every epoch, unique names are set and
-- dumplicates are remained for next epoch.
function Tabline:set_tab_names(tabnrs)
  if #tabnrs == 1 then
    self:set_name(self[tabnrs[1]])
    return
  end
  local name_nrs = {}
  for _, tabnr in ipairs(tabnrs) do
    local tab = self[tabnr]
    tab.cur = tab.cur + 1
    -- incase there are same names
    if tab.cur == tab.parts_len then
      self:set_name(tab)
    else
      local name = table.concat(tab.parts, '', 1, tab.cur)
      name_nrs[name] = name_nrs[name] or {}
      table.insert(name_nrs[name], tabnr)
    end
  end
  for _, nrs in pairs(name_nrs) do
    self:set_tab_names(nrs)
  end
end

function M.update()
  local tbl = Tabline:new()
  local tabline = ''
  for _, tab in ipairs(tbl) do
    tabline = tabline .. tab:get_section()
  end
  vim.o.tabline = tabline
end

-- move tab left
function M.tab_move_left()
  local tabnr = fn.tabpagenr() - 2
  if tabnr >= 0 then
    cmd(tabnr .. 'tabmove')
  else
    cmd('$tabmove')
  end
  M.update()
end

-- move tab right
function M.tab_move_right()
  local tabnr = fn.tabpagenr() + 1
  if tabnr <= fn.tabpagenr('$') then
    cmd(tabnr .. 'tabmove')
  else
    cmd('0tabmove')
  end
  M.update()
end

function M.move(nr)
  local cur_tabnr = fn.tabpagenr()
  nr = nr > fn.tabpagenr('$') and fn.tabpagenr('$') or nr
  if nr < cur_tabnr then
    nr = nr - 1 < 0 and 0 or nr - 1
  end
  cmd(nr .. 'tabmove')
  M.update()
end

return M
