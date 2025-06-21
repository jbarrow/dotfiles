vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.clipboard = "unnamedplus"
vim.o.nu = true
vim.o.relativenumber = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.autoread = true
vim.o.timeoutlen = 300
vim.o.wildignorecase = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false

vim.o.incsearch = true

vim.g.netrw_banner = 0

-- recursively add the current directory to the path, but ignore common file patterns
-- that we don't want to search.
vim.opt.path:append("**")
vim.opt.wildignore:append {"*.venv/*", "*/.git/*", "*/target/*", "*/__pycache__/*"}

