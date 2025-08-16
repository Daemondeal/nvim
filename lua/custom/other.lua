return {
  -- Color Scheme
  {
    'Shatur/neovim-ayu',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'ayu-dark'
      vim.cmd.hi 'Comment gui=none'

      -- Change the color of inlay hints
      vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = '#5b8177', bg = 'none', italic = true })

      -- Change color of relative line numbers
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#595959', bg = 'none' })
      vim.api.nvim_set_hl(0, 'NonText', { fg = '#595959', bg = 'none' })
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { 'tpope/vim-sleuth' },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>d_', hidden = true },
        { '<leader>r', group = '[R]ename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>t_', hidden = true },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>w_', hidden = true },
      }
    end,
  },

  -- Pair file types together
  {
    'rgroli/other.nvim',
    config = function()
      require('other-nvim').setup {
        mappings = {
          'python',
          'rust',
          'cpp',
          'c',
          {
            pattern = '(.*)%.h$',
            target = { '%1.c', '%1.cpp' },
          },
          {
            pattern = '(.*)%.c$',
            target = '%1.h',
          },
          {
            pattern = '(.*)%.cpp$',
            target = { '%1.hpp', '%1.h' },
          },
        },
      }

      vim.api.nvim_set_keymap('n', '<leader>ll', '<cmd>:Other<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ltn', '<cmd>:OtherTabNew<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ls', '<cmd>:OtherSplit<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>lv', '<cmd>:OtherVSplit<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>lc', '<cmd>:OtherClear<CR>', { noremap = true, silent = true })
    end,
  },

  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      ignore_install = { 'latex', 'tex' },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'latex', 'tex', 'c' },
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby', 'c' } },
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = false,
      }
      vim.api.nvim_set_keymap('n', '<leader>cs', '<cmd>:TSContext toggle<CR>', { noremap = true, silent = true })
    end,
  },

  {
    'stevearc/profile.nvim',
    config = function()
      local should_profile = os.getenv 'NVIM_PROFILE'
      if should_profile then
        require('profile').instrument_autocmds()
        if should_profile:lower():match '^start' then
          require('profile').start '*'
        else
          require('profile').instrument '*'
        end
      end

      local function toggle_profile()
        local prof = require 'profile'
        if prof.is_recording() then
          prof.stop()
          vim.ui.input({ prompt = 'Save profile to:', completion = 'file', default = 'profile.json' }, function(filename)
            if filename then
              prof.export(filename)
              vim.notify(string.format('Wrote %s', filename))
            end
          end)
        else
          prof.start '*'
        end
      end
      vim.keymap.set('', '<f1>', toggle_profile)
    end,
  },
}
