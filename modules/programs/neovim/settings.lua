local opt = vim.opt
local g = vim.g

vim.cmd [[
	syntax enable
	set nowrap
	set nobackup
	set nowritebackup
	set noerrorbells
	set noswapfile
]]

g.mapleader = ' '

-- undo file
opt.undofile = true
opt.undodir = "/home/rafa/.cache/"

-- indent
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

-- ui
opt.termguicolors = true
opt.cursorline = true
opt.number = true

-- viminfo file
opt.viminfo = ""
opt.viminfofile = "NONE"

-- misc
opt.smartcase = true
opt.ttimeoutlen = 5
opt.compatible = false
opt.autoread = true
opt.incsearch = true
opt.hidden = true
-- opt.shortmess = "atI"
