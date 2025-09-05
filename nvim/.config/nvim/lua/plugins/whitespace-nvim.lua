return {
  "johnfrankmorgan/whitespace.nvim",
  keys = {
    {
      "<leader>fw",
      function() require('whitespace-nvim').trim() end,
      desc = "Fix training whitespace"
    }
  },
  config = function ()
    require('whitespace-nvim').setup({
      highlight = 'DiffDelete',
    })
  end
}
