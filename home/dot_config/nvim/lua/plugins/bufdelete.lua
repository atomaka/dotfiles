return {
  "famiu/bufdelete.nvim",
  keys = {
    { "<Leader>bd", function() require("bufdelete").bufdelete(0, true) end }
  },
}
