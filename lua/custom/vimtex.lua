return {
  {
    'lervag/vimtex',
    lazy = false,
    init = function()
      -- Use sioyek for viewing the resulting pdf
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_latexmk = { options = { '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode', '-shell-escape' } }

      -- Disables a useless window opening after each compile
      vim.g.vimtex_quickfix_open_on_warning = 0
    end,
  },
}
