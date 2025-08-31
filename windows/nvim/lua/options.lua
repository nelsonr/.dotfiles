-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Shell fix for running terminal commands inside Neovim
vim.o.shell = "cmd.exe"

-- Use Space as leader key
vim.g.mapleader = " "

-- Show line numbers
vim.o.number = true

-- Use system clipboard
vim.o.clipboard = "unnamedplus"

-- Highlight cursor line
vim.o.cursorline = true

-- Highlight search results
vim.o.hlsearch = true

-- Ignore case when using lowercase in search
vim.o.ignorecase = true

-- But don't ignore it when using upper case
vim.o.smartcase = true

vim.o.smarttab = true
vim.o.smartindent = true

-- Convert tabs to spaces.
vim.o.expandtab = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.splitbelow = true
vim.o.splitright = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimum offset in lines to screen borders
vim.o.scrolloff = 12

-- Encoding
vim.fileencoding = "utf-8"

-- Hide blank lines "~"
vim.opt.fillchars = { eob = ' ' }

-- Set global status bar
vim.o.laststatus = 3

-- Hide default mode status text
vim.o.showmode = false
