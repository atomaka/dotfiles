local builtin = require('telescope.builtin')

vim.api.nvim_set_keymap('n', '<leader>t', ':Telescope<CR>', {
  noremap = true,
  silent = true,
})
vim.keymap.set("n", "<C-p>", function()
  builtin.find_files({
    file_ignore_patterns = {".git/", "node_modules/"},
    hidden = true,
    previewer = false,
  })
end)
vim.keymap.set('n', '<Leader>ff', function()
  builtin.find_files({
    file_ignore_patterns = {".git/", "node_modules/"},
    hidden = true,
    no_ignore = true,
    previewer = false,
  })
end)
vim.keymap.set('n', '<Leader>fg', function()
  builtin.live_grep({
    file_ignore_patterns = {".git/", "node_modules/"},
    hidden = true,
    previewer = false,
  })
end)
vim.keymap.set('n', '<Leader>fb', function()
  builtin.buffers()
end)

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' }
}
