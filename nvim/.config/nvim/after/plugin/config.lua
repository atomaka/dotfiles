-- PLUGIN CONFIGURATION
--- bufdelete.nvim
vim.keymap.set("n", "<Leader>bd", function()
  require("bufdelete").bufdelete(0, true)
end)

--- gitblame.nvim
vim.g.gitblame_use_blame_commit_file_urls = true
vim.g.gitblame_display_virtual_text = 0

require('gitblame').setup {enabled = true}

vim.api.nvim_set_keymap('n', '<leader>gbo', ':GitBlameOpenCommitURL<CR>', {
  noremap = true,
  silent = true,
})

--- gitlinker.nvim
require"gitlinker".setup({
  router = {
    browse = {
      ["^git%.atomaka%.com"] = "https://git.atomaka.com/"
        .. "{_A.ORG}/"
        .. "{_A.REPO}/commit/"
        .. "{_A.REV}/"
    },
    blame = {
      ["^git%.atomaka%.com"] = "https://git.atomaka.com/"
        .. "{_A.ORG}/"
        .. "{_A.REPO}/blame/"
        .. "branch/{_A.CURRENT_BRANCH}/"
        .. "{_A.FILE}"
    },
  },
})
vim.keymap.set(
  {"n", 'v'},
  "<leader>gl",
  function()
    require("gitlinker").link({ action = require("gitlinker.actions").system })
  end,
  { silent = true, noremap = true, desc = "GitLink!" }
)
vim.keymap.set(
  {"n", 'v'},
  "<leader>glb",
  function()
    require("gitlinker").link({
      router_type = "blame",
      action = require("gitlinker.actions").system,
    })
  end,
  { silent = true, noremap = true, desc = "GitLink! blame" }
)

--- gitsigns.nvim
require("gitsigns").setup()
vim.keymap.set("n", "<leader>gb", require("gitsigns").toggle_current_line_blame)

--- git-messanger.vim
vim.g["git_messenger_always_into_popup"] = 1

--- nvim-surround
require("nvim-surround").setup()

--- telescope.nvim
vim.api.nvim_set_keymap('n', '<leader>t', ':Telescope<CR>', {
  noremap = true,
  silent = true,
})
vim.keymap.set("n", "<C-p>", function()
    require("telescope.builtin").find_files({
      file_ignore_patterns = {".git/", "node_modules/"},
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
