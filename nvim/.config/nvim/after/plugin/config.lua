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

--- nvim-surround
require("nvim-surround").setup()

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

--- vim-zoom
-- let g:zoom#statustext='Z'
vim.api.nvim_tabpage_set_var(0, "zoomed", 0)
vim.keymap.set("n", "<C-w>", function()
  local char = vim.fn.nr2char(vim.fn.getchar())

  if vim.api.nvim_tabpage_get_var(0, "zoomed")== 1 then
    if char == 'v' or char == 's' or char == '' or char == '' then
      vim.notify("cannot split when zoomed", vim.log.levels.ERROR)
      return ""
    end
  end

  return "<C-w>"..char
end, {expr = true, replace_keycodes = true})
vim.keymap.set("n", "<C-w>z", "<Plug>(zoom-toggle)")
vim.keymap.set("n", "<C-w><C-z>", "<Plug>(zoom-toggle)")
