return {
  -- Autoformat
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      {
        '<leader>tf',
        function()
          if vim.g.disable_autoformat then
            Snacks.notify.info 'Enabled autoformat'
          else
            Snacks.notify.info 'Disabled autoformat'
          end

          vim.g.disable_autoformat = not vim.g.disable_autoformat
        end,
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local enabled_filetypes = { lua = true, python = true }
        if vim.g.disable_autoformat then
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = enabled_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
      },
    },
    init = function()
      vim.g.disable_autoformat = false
    end,
  },
}
