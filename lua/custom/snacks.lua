---@module "snacks"

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      -- dashboard = { enabled = true },
      indent = {
        enabled = true,
        animate = { enabled = false },
        scope = { enabled = false },
      },
      words = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 2000,
      },
      picker = { enabled = true },
      terminal = { enabled = true },
    },

    -- stylua: ignore
    keys = {
      { '<leader>lg', function() Snacks.lazygit() end, desc = '[L]azy [g]it', },
      { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },

      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

      -- Picker
      { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
      { '<leader>sg', function() Snacks.picker.grep()  end, desc = '[S]earch by [G]rep' },
      { '<leader>sc', function() Snacks.picker.grep_word() end, desc = '[S]earch [C]urrent word' },
      { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>uc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },

      -- TODO: Make it work where it puts <cword> in the buffer as a start
      { '<leader>sc', function() Snacks.picker.grep({ pattern = "<cword>" }) end, desc = '[S]earch [C]urrent word' },

      -- LSP Stuff
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { 'gD', function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { 'gI', function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    },

    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          Snacks.toggle.inlay_hints():map '<leader>uh'
          Snacks.toggle.indent():map '<leader>ug'
        end,
      })
    end,
  },
}
