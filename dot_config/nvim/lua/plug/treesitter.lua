local M = {}
local cmd = vim.cmd
local fn = vim.fn

local map = require('utils').map

local ft_enabled = {}
local queries
local parsers

function M.do_textobject(obj, inner, visual)
    local ret = false
    if queries.has_query_files(vim.bo.ft, 'textobjects') then
        require('nvim-treesitter.textobjects.select').select_textobject(
            ('@%s.%s'):format(obj, inner and 'inner' or 'outer'), visual and 'x' or 'o')
        ret = true
    end
    return ret
end

local function init()
  local conf = {
    ensure_installed = {
      'bash', 'c', 'cpp', 'cmake', 'latex', 'python', 'json', 'lua', 'yaml'
    },

    highlight = {enable = true, disable = {'bash', 'html'}},
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner'
        }
      },
      move = {
        enable = true,
        goto_next_start = {[']m'] = '@function.outer'},
        goto_next_end = {[']M'] = '@function.outer', [']f'] = '@function.outer'},
        goto_previous_start = {['[m'] = '@function.outer', ['[f'] = '@function.outer'},
        goto_previous_end = {['[M'] = '@function.outer'}
      }
    },
    matchup = {enable = false}
  }

  cmd('pa nvim-treesitter')
  cmd('pa nvim-treesitter-textobjects')

  require('nvim-treesitter.configs').setup(conf)

  parsers = require('nvim-treesitter.parsers')
  queries = require('nvim-treesitter.query')
  local hl_disabled = conf.highlight.disable or {}
  for _, lang in ipairs(conf.ensure_installed) do
    if not vim.tbl_contains(hl_disabled, lang) then
      local ft_tbl = parsers.list[lang].used_by
      if ft_tbl then
        for _, ft in ipairs(ft_tbl) do
          ft_enabled[ft] = true
        end
      else
        ft_enabled[lang] = true
      end
    end
  end
end

init()

return M
