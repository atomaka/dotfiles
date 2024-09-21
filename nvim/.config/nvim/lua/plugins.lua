local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "famiu/bufdelete.nvim",
  "dhruvasagar/vim-zoom",
  "gpanders/editorconfig.nvim",
  "johnfrankmorgan/whitespace.nvim",
  "kylechui/nvim-surround",
  -- "FabijanZulj/blame.nvim",
  "rhysd/git-messenger.vim",
  "lewis6991/gitsigns.nvim",
  "linrongbin16/gitlinker.nvim",
  "tpope/vim-eunuch",

  "gruvbox-community/gruvbox",

  -- languages
  "fatih/vim-go",
  "hashivim/vim-terraform",
  "leafgarland/typescript-vim",
  "tpope/vim-markdown",
  "tpope/vim-rails",
  "vim-ruby/vim-ruby",
})
