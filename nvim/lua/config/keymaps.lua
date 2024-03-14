vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

local tcbuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tcbuiltin.find_files, {})
vim.keymap.set('n', '<leader>gg', tcbuiltin.live_grep, {})
