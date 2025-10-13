require("config.lazy")

-- current theme is Fluoromachine: https://github.com/maxmx03/fluoromachine.nvim

-- ignore case during search
vim.opt.ignorecase = true

-- enable line numbers
vim.opt.number = true

-- sets the number column width to 4 characters
vim.opt.numberwidth = 4 

-- Set tabstop to 4 spaces
vim.opt.tabstop = 4

-- Set shiftwidth to 4 spaces
vim.opt.shiftwidth = 4

-- Optional: Also set softtabstop and expandtab for consistent indentation
vim.opt.softtabstop = 4

-- Convert tabs to spaces
vim.opt.expandtab = true 

-- syntax highlighting on
vim.opt.syntax = "on" 

-- paste whatever's in our clipboard to the buffer
vim.opt.clipboard = "unnamedplus"

-- relative line numbers
vim.wo.relativenumber = true
