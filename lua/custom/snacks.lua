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
      terminal = { enabled = true },
    },

    -- stylua: ignore
    keys = {
      { '<leader>lg', function() Snacks.lazygit() end, desc = '[L]azy [g]it', },
      { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
    },

    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          Snacks.toggle.inlay_hints():map '<leader>uh'
        end,
      })
      vim.g.disable_autoformat = false
    end,
  },
}
