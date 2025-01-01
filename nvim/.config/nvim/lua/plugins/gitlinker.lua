return {
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {
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
    },
    keys = {
      { "<leader>gl", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Gitlink!" },
      { "<leader>glb", "<cmd>GitLink! blame<cr>", mode = { "n", "v" }, desc = "Gitlink! blame" },
    },
  },
}
