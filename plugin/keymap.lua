local set = vim.keymap.set

-- Diagnostic keymaps
set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous [D]iagnostic message' })

set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next [D]iagnostic message' })

set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

set('n', '<leader>p', '"_dp', { desc = '[P]aste without yanking' })
set('v', '<leader>p', '"_dP', { desc = '[P]aste without yanking' })

set({ 'n', 'v' }, '<leader>P', '"_dP', { desc = '[P]aste without yanking' })
set({ 'n', 'v' }, '<leader>d', '"_d', { desc = '[D]elete without yanking' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- These mappings control the size of splits (height/width)
set('n', '<M-l>', '<c-w>5<')
set('n', '<M-h>', '<c-w>5>')
set('n', '<M-k>', '<C-W>+')
set('n', '<M-j>', '<C-W>-')

-- NOTE: Replaced with Oil

-- Keybinds for opening the file manager
-- set('n', '<leader>pv', '<cmd>Ex<CR>')
-- Move selection up or down
set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")

-- Reformat comment
set('v', '<leader>ca', 'gcgqgc', { desc = '[C]omment [A]lign' })

-- Toggle Inlay Hints
set('n', '<leader>ci', '<cmd> lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', { desc = '[C]ode toggle [I]nlay hints' })

set('n', '<leader>gu', '<cmd> lua require("telescope.builtin").lsp_references()<CR>', { desc = '[G]o [U]sages' })

vim.keymap.set('n', '<leader>gf', function()
  local clip = vim.fn.getreg '+'
  local file, lineno = string.match(clip, '([^:]+):(%d+)')
  if file and lineno then
    vim.cmd('edit ' .. file)
    vim.cmd(lineno)
  else
    print "Clipboard content not in 'file:line' format"
  end
end, { desc = 'Go to file and line from clipboard' })

vim.keymap.set('n', '<leader>cl', function()
  local file = vim.fn.expand '%'
  local line = vim.fn.line '.'
  local result = string.format('%s:%d', file, line)
  vim.fn.setreg('+', result)
  print('Copied to clipboard: ' .. result)
end, { desc = 'Copy current file:line to clipboard' })

-- Run sync.sh
set('n', '<leader>us', '<cmd>!./sync.sh<cr>', { desc = '[U]pload to [s]erver' })
set('n', '<leader>rr', '<cmd>!%<CR>', { desc = '[R]un current buffer ' })

-- Tabs
vim.keymap.set('n', '<M-1>', '1gt')
vim.keymap.set('n', '<M-2>', '2gt')
vim.keymap.set('n', '<M-3>', '3gt')
vim.keymap.set('n', '<M-4>', '4gt')
vim.keymap.set('n', '<M-5>', '5gt')
vim.keymap.set('n', '<M-6>', '6gt')
vim.keymap.set('n', '<M-7>', '7gt')

-- Neovide scale factor control
vim.g.neovide_scale_factor = 0.8
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
set('n', '<C-=>', function()
  change_scale_factor(1.125)
end)
set('n', '<C-->', function()
  change_scale_factor(1 / 1.125)
end)
