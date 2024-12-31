return {
  "f-person/auto-dark-mode.nvim",
  opts = {
    update_interval = 3000,
    set_dark_mode = function()
      -- vim.api.nvim_set_option_value("background", "dark", {})
      vim.opt.background = "dark"
      -- vim.cmd("colorscheme gruvbox")
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {})
      vim.opt.background = "light"
      -- vim.cmd("colorscheme gruvbox")
    end,
  },
}
