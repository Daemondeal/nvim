-- Initial configuration setup

-- This must be done first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

-- Add lazy to 'runtimepath', in order to 'require' it later
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { import = 'custom' },
}

local ms_path = vim.fn.stdpath 'config' .. '/lua/machine-specific'
if vim.loop.fs_stat(ms_path) then
  table.insert(plugins, {
    dir = ms_path,
    name = 'machine-specific',
    lazy = false,
  })
end

require('lazy').setup(plugins, {
  change_detection = {
    notify = false,
  },
})
