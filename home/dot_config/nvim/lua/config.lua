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

-- LEADER CONFIGURATION
vim.keymap.set("n", "<leader>sz", ":luafile ~/.config/nvim/init.lua<cr>")

vim.keymap.set({ "n", "v" }, "<leader>cp", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>pa", '"+P')

vim.keymap.set("n", "<leader>cs", ":let @/ = ''<cr>")
vim.keymap.set("n", "<leader>fj", ":%!jq .<cr>")
vim.keymap.set("n", "<leader>gg", ":exe '!gh gist create -w %:p'<cr><cr>")

vim.keymap.set('n', '<leader>sa', ':Move %<tab>')

-- pairing
vim.keymap.set("n", "<leader>pm", function()
  vim.opt.relativenumber = not(vim.opt.relativenumber:get())
end)

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
