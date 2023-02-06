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

--- packer.nvim
vim.keymap.set("n", "<Leader>pi", function()
  vim.cmd("PackerCompile")
  vim.cmd("PackerInstall")
end)
vim.keymap.set("n", "<Leader>pu", ":PackerSync<CR>")
vim.keymap.set("n", "<Leader>pc", ":PackerClean<CR>")

--- telescope.nvim
vim.keymap.set("n", "<C-p>", function()
    require("telescope.builtin").find_files({
      hidden = true,
      previewer = false,
    })
end)
vim.keymap.set('n', '<Leader>ff', function()
  require("telescope.builtin").find_files({
    file_ignore_patterns = {".git/", "node_modules/"},
    hidden = true,
    no_ignore = true,
    previewer = false,
  })
end)
vim.keymap.set('n', '<Leader>fg', function()
  require("telescope.builtin").live_grep({
    file_ignore_patterns = {".git/", "node_modules/"},
    hidden = true,
    previewer = false,
  })
end)
vim.keymap.set('n', '<Leader>fb', function()
  require("telescope.builtin").buffers()
end)

--- whitespace.nvim
require("whitespace-nvim").setup({
  hightlight = "red"
})
vim.keymap.set("n", "<Leader>fw", function()
  require("whitespace-nvim").trim()
end, { silent = true })
