return {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>gbo", "<cmd>GitBlameOpenCommitURL<CR>", desc = "Open Commit" }
    },
    opts = {
        enabled = true,
        use_blame_commit_file_urls = true,
        display_virtual_text = false
    },
}
