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

return {
  "dhruvasagar/vim-zoom",
  keys = {
    { "<C-w>z", "<Plug>(zoom-toggle)" },
    { "<C-w><C-z>", "<Plug>(zoom-toggle)" },
  }
}
