vim.g.git_messenger_always_into_popup = 1

local user_git_hosts = {
  {
    pattern = "git%.atomaka%.com[:/]([^/]+)/([^/%.]+)",
    pr_path = "https://git.atomaka.com/%s/%s/pulls/%s",
    pr_pattern = "%(#(%d+)%)"
  }
}

local default_git_hosts = {
  {
    pattern = "github%.com[:/]([^/]+)/([^/%.]+)",
    pr_path = "https://github.com/%s/%s/pull/%s",
    pr_pattern = "%(#(%d+)%)"
  },
  {
    pattern = "gitlab%.com[:/]([^/]+)/([^/%.]+)",
    pr_path = "https://gitlab.com/%s/%s/-/merge_requests/%s",
    pr_pattern = "!(%d+)"
  },
  {
    pattern = "bitbucket%.org[:/]([^/]+)/([^/%.]+)",
    pr_path = "https://bitbucket.org/%s/%s/pull-requests/%s",
    pr_pattern = "%(#(%d+)%)"
  }
}

local function get_git_hosts()
  local hosts = {}

  for _, host in ipairs(user_git_hosts) do
    table.insert(hosts, host)
  end

  for _, host in ipairs(default_git_hosts) do
    table.insert(hosts, host)
  end

  return hosts
end

local function find_pr_reference(pr_pattern)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for _, line in ipairs(lines) do
    local pr_number = line:match(pr_pattern)
    if pr_number then
      return pr_number
    end
  end
  return nil
end

local function open_pr_from_commit()
  local result = vim.system({ "git", "remote", "get-url", "origin" }, { text = true }):wait()
  if result.code ~= 0 then
    vim.notify("Failed to get remote URL", vim.log.levels.ERROR)
    return
  end

  local url = vim.trim(result.stdout)

  for _, host in ipairs(get_git_hosts()) do
    local owner, repo = url:match(host.pattern)
    if owner and repo then
      repo = repo:gsub("%.git$", "")

      local pr_pattern = host.pr_pattern or "%(#(%d+)%)"
      local pr_number = find_pr_reference(pr_pattern)

      if not pr_number then
        vim.notify("No PR/MR reference found", vim.log.levels.WARN)
        return
      end

      local pr_url = string.format(host.pr_path, owner, repo, pr_number)

      local opener = vim.fn.has("mac") and "open" or "xdg-open"
      if vim.fn.executable(opener) ~= 1 then
        vim.notify("Failed to find URL opener", vim.log.levels.ERROR)
        return
      end

      vim.system({ opener, pr_url }):wait()
      vim.notify(string.format("Opening PR #%s", pr_number), vim.log.levels.INFO)
      return
    end
  end

  vim.notify("Unsupported git host", vim.log.levels.ERROR)
end

return {
  "rhysd/git-messenger.vim",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "gitmessengerpopup",
      group = vim.api.nvim_create_augroup("GitMessengerPR", { clear = true }),
      callback = function()
        vim.keymap.set("n", "p", open_pr_from_commit, {
          buffer = true,
          desc = "Open PR in browser",
          silent = true
        })
      end,
    })
  end,
}
