vim.cmd('pa telescope.nvim')
vim.cmd('pa telescope-fzf-native.nvim')
vim.cmd('pa telescope-symbols.nvim')
vim.cmd('pa telescope-file-browser.nvim')
vim.cmd('pa telescope-coc.nvim')
local actions       = require('telescope.actions')
local action_layout = require('telescope.actions.layout')
local action_state  = require('telescope.actions.state')
local fb_actions    = require('telescope').extensions.file_browser.actions
local fb_utils      = require('telescope').extensions.file_browser.actions
local Path          = require('plenary.path')

local open = function(command)
  return function(prompt_bufnr)
    require('telescope.actions.set').edit(prompt_bufnr, command)
  end
end

local open_help = function(command)
  return function(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    if selection == nil then
      print "[telescope] Nothing currently selected"
      return
    end
    actions.close(prompt_bufnr)
    vim.cmd(command .. ' ' .. selection.value)
    vim.cmd('vert resize 82')
  end
end

local fb_default = function(prompt_bufnr)
  local p = Path:new(action_state.get_selected_entry())
  if p:is_dir() then
    actions.select_default(prompt_bufnr)
  else
    actions.select_tab(prompt_bufnr)
  end
end

require('telescope').setup{
  defaults = {
    -- see defalt mapping in
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
    mappings = {
      i = {
        -- forbidden
        ['<c-n>']   = false,
        ['<c-p>']   = false,
        ['<c-u>']   = false,
        ['<c-d>']   = false,
        ['<c-x>']   = false,
        ['<c-v>']   = false,
        ['<c-t>']   = false,
        ['<c-q>']   = false,
        ['<c-l>']   = false,
        ['<c-_>']   = false,
        ['<c-w>']   = false,
        -- custom
        ['<c-j>']   = actions.move_selection_next,
        ['<down>']  = actions.move_selection_next,
        ['<c-k>']   = actions.move_selection_previous,
        ['<up>']    = actions.move_selection_previous,
        ['<m-q>']   = actions.close,
        ['<c-c>']   = actions.close,
        ['<cr>']    = actions.select_default,
        ['<m-m>']   = actions.select_tab,
        ['<m-k>']   = open('to new'),
        ['<m-j>']   = open('bot new'),
        ['<m-h>']   = open('to vnew'),
        ['<m-l>']   = open('bot vnew'),
        ['<m-u>']   = actions.preview_scrolling_up,
        ['<m-d>']   = actions.preview_scrolling_down,
        ['<tab>']   = actions.toggle_selection + actions.move_selection_worse,
        ['<s-tab>'] = actions.toggle_selection + actions.move_selection_better,
        ['<m-/>']   = actions.which_key,
        ['<m-p>']   = action_layout.toggle_preview,
      },

      n = {
        -- forbidden
        ['<c-x>']   = false,
        ['<c-v>']   = false,
        ['<c-t>']   = false,
        ['<c-q>']   = false,
        ['<c-u>']   = false,
        ['<c-d>']   = false,
        ['L']       = false,
        ['?']       = false,
        ['gg']      = false,
        -- custom
        ['<esc>']   = actions.close,
        ['<m-q>']   = actions.close,
        ['qq']      = actions.close,
        ['<cr>']    = actions.select_default,
        ['K']       = open('to new'),
        ['J']       = open('bot new'),
        ['H']       = open('to vnew'),
        ['L']       = open('bot vnew'),
        ['t']       = actions.select_tab,
        ['<tab>']   = actions.toggle_selection + actions.move_selection_worse,
        ['<s-tab>'] = actions.toggle_selection + actions.move_selection_better,
        ['<m-p>']   = action_layout.toggle_preview,

        -- TODO: This would be weird if we switch the ordering.
        ['j']       = actions.move_selection_next,
        ['k']       = actions.move_selection_previous,
        ['M']       = actions.move_to_middle,

        ['<down>']  = actions.move_selection_next,
        ['<up>']    = actions.move_selection_previous,
        ['g']       = actions.move_to_top,
        ['G']       = actions.move_to_bottom,

        ['<m-u>']   = actions.preview_scrolling_up,
        ['<m-d>']   = actions.preview_scrolling_down,

        ['/']       = actions.which_key,
      },
    },

    layout_config = {
      horizontal = {
         width = 0.9,
         preview_width = 0.5,
         prompt_position = 'top',
      },
    },

    sorting_strategy = 'ascending',

    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim' -- add this value to trim blank at beginning
    }
  },

  -- not work
  pickers = {
    find_files = {
      mappings = {
        i = {
          ['<cr>']  = actions.select_tab,
          ['<m-m>'] = actions.select_default,
        },
        n = {
          ['<cr>']  = actions.select_tab,
          ['e']     = actions.select_default,
        },
      }
    },
    oldfiles = {
      mappings = {
        i = {
          ['<cr>']  = actions.select_tab,
          ['<m-m>'] = actions.select_default,
        },
        n = {
          ['<cr>']  = actions.select_tab,
          ['e']     = actions.select_default,
        },
      }
    },
    help_tags = {
      mappings = {
        i = {
          ['<m-k>'] = open_help('to h'),
          ['<m-j>'] = open_help('bot h'),
          ['<m-h>'] = open_help('vert to h'),
          ['<m-l>'] = open_help('vert bot h'),
        },
        n = {
          ['K'] = open_help('to h'),
          ['J'] = open_help('bot h'),
          ['H'] = open_help('vert to h'),
          ['L'] = open_help('vert bot h'),
        }
      }
    },
    live_grep = {
      layout_config = {
        width = function(_, max_columns, _)
          return math.min(max_columns, 120)
        end
      }
    },
    current_buffer_fuzzy_find = {
      layout_config = {
        width = function(_, max_columns, _)
          return math.min(max_columns, 120)
        end
      }
    },
  },

  -- You dont need to set any of these options. These are the default ones. Only
  -- the loading is important
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matjkching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
                                       -- the default case_mode is 'smart_case'
    },

    file_browser = {
      hide_parent_dir = true,
      select_buffer = true,
      no_ignore = true,
      layout_config = {
        horizontal = { width = 0.9, preview_width=0.7 },
      },
      -- initial_mode = 'normal',
      mappings = {
        n = {
          ['c']     = fb_actions.create,
          ['r']     = fb_actions.rename,
          ['m']     = fb_actions.move,
          ['y']     = fb_actions.copy,
          ['d']     = fb_actions.remove,
          ['.']     = fb_actions.toggle_hidden,
          ['h']     = fb_actions.goto_parent_dir,
          ['e']     = actions.select_default,
          ['<m-m>'] = actions.select_default,
          ['l']     = fb_default,
          ['<cr>']  = actions.select_tab,
          ['K']     = open('to new'),
          ['J']     = open('bot new'),
          ['H']     = open('to vnew'),
          ['L']     = open('bot vnew'),
          ['<m-k>'] = open('to new'),
          ['<m-j>'] = open('bot new'),
          ['<m-h>'] = open('to vnew'),
          ['<m-l>'] = open('bot vnew'),
        },
      },
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('coc')
