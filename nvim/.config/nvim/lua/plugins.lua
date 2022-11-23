local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  local use = use

  use "wbthomason/packer.nvim"
  -- TODO: autoupdate (but after plugins separate file
  -- augroup packer_user_config
  --   autocmd!
  --   autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  -- augroup end

  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope.nvim"

  use "famiu/bufdelete.nvim"
  use "gpanders/editorconfig.nvim"
  use "johnfrankmorgan/whitespace.nvim"
  use "kylechui/nvim-surround"
  use "lewis6991/gitsigns.nvim"
  use "nyngwang/NeoZoom.lua" -- TODO: Floating window background color
  use "ruifm/gitlinker.nvim"
  use "tpope/vim-eunuch"

  use "gruvbox-community/gruvbox"

  if packer_bootstrap then
    require('packer').sync()
  end
end)
