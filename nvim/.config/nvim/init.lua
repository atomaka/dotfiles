local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  local use = use

  use "wbthomason/packer.nvim"
  -- TODO: autoupdate (but after plugins separate file
  -- augroup packer_user_config
  --   autocmd!
  --   autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  -- augroup end

  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope.nvim"

  use "nvim-treesitter/nvim-treesitter"
  use "nvim-treesitter/nvim-treesitter-context"

  use "famiu/bufdelete.nvim"
  use "gpanders/editorconfig.nvim"
  use "johnfrankmorgan/whitespace.nvim"
  use "kylechui/nvim-surround"
  use "lewis6991/gitsigns.nvim"
  use "nyngwang/NeoZoom.lua" -- TODO: Floating window background color
  use "ruifm/gitlinker.nvim"

  use "gruvbox-community/gruvbox"
end)

--- SETTING CONFIGURATION
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

-- REMAP CONFIGURATION
--- Stay in visual mode while tabbing
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

--- quick replacement
vim.keymap.set("n", "S", ":%s//g<LEFT><LEFT>")
vim.keymap.set("v", "S", 'y:%s/<C-r><C-r>"//g<Left><Left>')

--- COMMAND CONFIGURATION
--- Avoid typos
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wq", "wq", {})

-- CUSTOM CONFIGURATION
--- Targetting!
local reticle = vim.api.nvim_create_augroup("Reticle", {
  clear = true
})

vim.api.nvim_create_autocmd({"VimEnter", "WinEnter", "BufWinEnter"}, {
    group = reticle,
    callback = function()
      vim.opt_local.cursorline = true
      vim.opt_local.cursorcolumn = true
    end
})
vim.api.nvim_create_autocmd({"WinLeave"}, {
    group = reticle,
    callback = function()
      vim.opt_local.cursorline = false
      vim.opt_local.cursorcolumn = false
    end
})

--- background matching terminal
function ChangeBackground()
  local file = io.open(os.getenv("HOME") .. "/.config/atomaka/color.yml", "rb")
  local background = file:read()
  file:close()
  vim.opt.background = background
end
ChangeBackground()

-- LEADER CONFIGURATION
vim.g.mapleader = ","

vim.keymap.set("n", "<leader>sz", ":luafile ~/.config/nvim/init.lua<cr>")

vim.keymap.set({ "n", "v" }, "<leader>cp", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>pa", '"+P')

vim.keymap.set("n", "<leader>cs", ":let @/ = ''<cr>")
vim.keymap.set("n", "<leader>fj", ":%!jq .<cr>")
vim.keymap.set("n", "<leader>gg", ":exe '!gh gist create -w %:p'<cr><cr>")

--- tabs
vim.keymap.set("n", "<Leader>2", function()
  print("Setting tabstop to 2")
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
end)
vim.keymap.set("n", "<Leader>4", function()
  print("Setting tabstop to 4")
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
end)
vim.keymap.set("n", "<Leader>a", function()
  print("Setting tabstop to tab")
  vim.opt.tabstop = 8
  vim.opt.shiftwidth = 8
  vim.opt.expandtab = false
end)
vim.keymap.set("n", "<Leader>st", ':let @/ = "\t"<cr>')

-- COLOR CONFIGURATION
vim.cmd("colorscheme gruvbox")
vim.api.nvim_create_autocmd({"ColorScheme", "BufWinEnter"}, {
  callback = function()
    vim.cmd("hi Normal ctermbg=NONE guibg=NONE")
  end,
})

-- PLUGIN CONFIGURATION
--- bufdelete.nvim
vim.keymap.set("n", "<Leader>bd", function()
  require("bufdelete").bufdelete(0, true)
end)

--- gitlinker.nvim
require"gitlinker".setup()
vim.keymap.set("n", "<Leader>gh", function()
  require"gitlinker".get_buf_range_url(
    "n",
    { action_callback = require"gitlinker.actions".open_in_browser }
  )
end, { silent = true })
vim.keymap.set("v", "<leader>gh", function()
  require"gitlinker".get_buf_range_url(
    "v",
    { action_callback = require"gitlinker.actions".open_in_browser }
  )
end)

--- gitsigns.nvim
require("gitsigns").setup()
vim.keymap.set("n", "<leader>gb", require("gitsigns").toggle_current_line_blame)

--- NeoZoom.lua
require("neo-zoom").setup({
  left_ratio = 0,
  top_ratio = 0,
  width_ratio = 1,
  height_ratio = 1,
  border = "none",
})
vim.keymap.set("n", "<C-w>z", require("neo-zoom").neo_zoom)

--- nvim-surround
require("nvim-surround").setup()

--- nvim-treesitter
require"nvim-treesitter.configs".setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "phpdoc" }, -- TODO: https://github.com/claytonrcarter/tree-sitter-phpdoc/issues/15

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- nvim-treesitter-context
require("treesitter-context").setup({
  patterns = {
    rust = {
      -- default rust
      "impl_item",
      "struct",
      "enum",

      -- substrate xD
      "macro_invocation",
    },
  },
})

--- packer.nvim
vim.keymap.set("n", "<Leader>pi", function()
  vim.cmd("PackerCompile")
  vim.cmd("PackerInstall")
end)
vim.keymap.set("n", "<Leader>pu", ":PackerSync<CR>")
vim.keymap.set("n", "<Leader>pc", ":PackerClean<CR>")

--- telescope.nvim
vim.keymap.set("n", "<C-p>", function()
    require("telescope.builtin").git_files()
end)

--- whitespace.nvim
require("whitespace-nvim").setup({
  hightlight = "red"
})
vim.keymap.set("n", "<Leader>fw", function()
  require("whitespace-nvim").trim()
end, { silent = true })
