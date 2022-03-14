vim.cmd('pa surround.nvim')
require('surround').setup {
  context_offset = 100,
  load_autogroups = false,
  mappings_style = "sandwich",
  map_insert_mode = true,
  quotes = {"'", '"'},
  brackets = {"(", '{', '[', '$'},
  space_on_closing_char = false,
  pairs = {
    nestable = {
       h = { "(", ")" },
       j = { "[", "]" },
       k = { "{", "}" },
       l = { "<", ">" }
    },
    linear = {
       g = { "'", "'" },
       f = { '"', '"' },
       d = { '"""', '"""' },
       s = { "`", "`" },
       a = { '$', '$' }
    }
  },
  prefix = "s"
}
