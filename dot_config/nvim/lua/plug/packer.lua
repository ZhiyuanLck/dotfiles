local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if not vim.loop.fs_stat(install_path) then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd('pa packer.nvim')

local packer = require('packer')
packer.on_compile_done = function()
  local fp = assert(io.open(packer.config.compile_path, 'rw+'))
  local wbuf = {}
  local key_state = 0
  for line in fp:lines() do
    if key_state == 0 then
      table.insert(wbuf, line)
      if line:find('Keymap lazy%-loads') then
        key_state = 1
        table.insert(wbuf, [[vim.schedule(function() vim.defer_fn(function()]])
      end
    elseif key_state == 1 then
      if line == '' then
        key_state = 2
        table.insert(wbuf, ('end, %d) end)'):format(100))
      end
      local _, e1 = line:find('vim%.cmd')
      if line:find('vim%.cmd') then
        local s2, e2 = line:find('%S+%s', e1 + 1)
        local map_mode = line:sub(s2, e2)
        line = ('pcall(vim.cmd, %s<unique>%s)'):format(map_mode, line:sub(e2 + 1))
      end
      table.insert(wbuf, line)
    else
      table.insert(wbuf, line)
    end
  end

  if key_state == 2 then
    fp:seek('set')
    fp:write(table.concat(wbuf, '\n'))
  end

  fp:close()
end

return packer.startup({
  config = {
    opt_default = true,
    display = {open_cmd = 'tabedit', keybindings = {prompt_revert = 'r', diff = 'D'}},
  },
  function(use, use_rocks)
    use {'wbthomason/packer.nvim',
      setup = function()
        if vim.g['loaded_nerd_comments'] ~= nil then
          vim.g['loaded_nerd_comments'] = nil
        end
        if vim.g.loaded_visual_multi == 1 then
          vim.schedule(function()
            vim.fn['vm#plugs#permanent']()
          end)
        end
      end
    }
    use 'nanotee/luv-vimdocs'
    use {'ZhiyuanLck/smart-pairs', event = "InsertEnter",
      config = function() require('pairs'):setup() end
    }
    use {'sirver/ultisnips'}
    use {'lervag/vimtex', ft = {'tex', 'plaintex'},
      setup = function() require('plug.tex') end
    }
    use {'machakann/vim-sandwich'}
    use {'wellle/targets.vim'}
    use {'justinmk/vim-sneak', keys = {'<Plug>Sneak_s', '<Plug>Sneak_S'},
      setup = function()
        vim.api.nvim_set_var('sneak#label', 1)
      end
    }
    use {'ZhiyuanLck/vim-diary'}
    use {'junegunn/vim-easy-align', keys = '<Plug>(EasyAlign)'}
    use {'preservim/nerdcommenter', keys = '<Plug>NERDCommenterToggle'}
    use {'tweekmonster/startuptime.vim', cmd = 'StartupTime'}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    use {'lukas-reineke/indent-blankline.nvim'}
    use {'folke/tokyonight.nvim'}
    use {'mg979/vim-visual-multi', branch = 'master', keys = '<c-n>'}
    use {'norcalli/nvim-colorizer.lua', ft = {'lua', 'vim'},
      config = function()
        require('colorizer').setup({'lua'; 'vim'})
        vim.cmd('ColorizerToggle')
      end,
    }
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {'nvim-telescope/telescope-file-browser.nvim'}
    use {'nvim-telescope/telescope-symbols.nvim'}
    -- lsp
    use {'neoclide/coc.nvim', branch = 'release'}
    use {'fannheyward/telescope-coc.nvim'}
    use {'danymat/neogen', requires = "nvim-treesitter/nvim-treesitter"}
    -- git
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
    }
    use {'tpope/vim-fugitive'}
  end
})
