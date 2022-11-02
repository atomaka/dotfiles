-- SETTING CONFIGURATION
vim.opt.autowrite = true
-- vim.opt.backspace = 2 -- default in neovim?
vim.opt.cpoptions:append("$")
-- vim.opt.endofline -- default in neovim?
-- vim.opt.laststatus = 2 -- default in neovim?
-- vim.opt.backup = false -- default in neovim?
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.scrolloff = 3
vim.opt.showmatch = true
-- vim.opt.showmode = true -- default in neovim?
-- vim.opt.showmode = true -- default in neovim?
vim.opt.timeoutlen = 500
vim.opt.virtualedit = "all"
-- vim.opt.hlsearch = true -- default in neovim?
vim.opt.ignorecase = true
-- vim.opt.incsearch = true -- default in neovim?
vim.opt.smartcase = true
-- vim.opt.wrapscan = true -- default in neovim?

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.textwidth = 80
vim.opt.colorcolumn = {80, 120}

-- Tabs are 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.shiftround = true                 -- make >> go to next tab

-- undo
vim.opt.undolevels = 5000
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"
