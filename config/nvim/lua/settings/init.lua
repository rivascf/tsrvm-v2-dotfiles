local set = vim.opt

--Nvim notifications plugin
vim.notify = require("notify")

--Nvim options confiuration
--file
set.fileencoding = 'utf-8'

--tab 
set.expandtab = true
set.smarttab = true
set.shiftwidth = 4
set.tabstop = 4

--search
set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true

--split
set.splitbelow = true
set.splitright = true
set.wrap = false
set.scrolloff = 5

--line numbers
set.number = true
set.relativenumber = true


