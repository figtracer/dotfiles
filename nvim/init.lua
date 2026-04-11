vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('options')
require('keymaps')
require('plugins.lazy')
require('plugins.lsp')
require('plugins.treesitter')
require('plugins.tele')
require('plugins.trouble')
require('plugins.gitsigns')
require('plugins.lualine')
require('plugins.zenmode')
require('misc')

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
