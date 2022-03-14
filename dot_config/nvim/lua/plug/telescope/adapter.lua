local M          = {}
local u          = require('utils')
local builtin    = require('telescope.builtin')
local themes     = require('telescope.themes')
local extensions = require('telescope').extensions
local fb         = extensions.file_browser
local coc        = extensions.coc

local dropdown = function(opts)
  opts = {
    layout_config = {
      preview_cutoff = 1,
      width = 0.9,
      height = function(_, _, max_lines)
        return math.min(max_lines, 15)
      end,
    },
    unpack(opts or {})
  }
  return themes.get_dropdown(opts)
end

local function live_grep(opts)
  builtin.live_grep(dropdown({width = 0.9, disable_coordinates = true, unpack(opts)}))
end

function M.find_line()
  builtin.current_buffer_fuzzy_find(dropdown({skip_empty_lines = true}))
end

function M.live_grep_root()
  live_grep({cwd = u.find_root()})
end

function M.live_grep_current()
  live_grep({cwd = u.cwd()})
end

function M.live_grep_opened()
  live_grep({grep_open_files = true})
end

function M.find_file()
  local opts = {
    cwd       = u.find_root(),
    hidden    = true,
    -- no_ignore = true,
  }
  builtin.find_files(opts)
end

function M.file_browser()
  fb.file_browser({cwd = u.cwd()})
end

function M.emoji()
  builtin.symbols{sources={'emoji', 'kaomoji', 'gitmoji'}}
end

local function new_coc(export, name)
  name = name or export
  M[export] = function() coc[name](dropdown()) end
end

new_coc('references', 'references_used')
new_coc('definitions')
new_coc('declarations')
new_coc('implementations')
new_coc('type_definitions')
new_coc('diagnostics')
new_coc('code_actions')
new_coc('line_code_actions')
new_coc('file_code_actions')
new_coc('document_symbols')
new_coc('workspace_symbols')
new_coc('workspace_diagnostics')

-- M.references       = function() coc.references_used(dropdown()) end
-- M.definitions      = function() coc.definitions(dropdown()) end
-- M.declarations     = function() coc.declarations(dropdown()) end
-- M.implementations  = function() coc.implementations(dropdown()) end
-- M.type_definitions = function() coc.type_definitions(dropdown()) end

return M
