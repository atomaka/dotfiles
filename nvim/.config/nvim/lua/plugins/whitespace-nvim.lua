return {
  "johnfrankmorgan/whitespace.nvim",
  config = function ()
    require('whitespace-nvim').setup({
      highlight = 'DiffDelete',
    })
  end,
  keys = {
    {
      "<leader>fw",
      function() require('whitespace-nvim').trim() end,
      desc = "Fix training whitespace"
    }
  }
}
