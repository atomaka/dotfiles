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

-- Upstream bug: gitmessenger#git#root_dir()'s "inside .git directory" guard
-- does a raw string-prefix check (stridx(from, dotgit) == 0). When dotgit is
-- a worktree gitfile like ".../repo/.git" (no trailing separator, since it
-- comes from findfile() rather than finddir()), that string is itself a
-- prefix of ".../repo/.github/...", so any file under .github/ is wrongly
-- treated as being inside .git and root_dir() returns ''. Upstream issue #70
-- fixed only the finddir() (regular .git directory, trailing-slash) case,
-- not this findfile()/worktree case:
-- https://github.com/rhysd/git-messenger.vim/issues/70
--
-- Force-redefine just this one function after the plugin loads, rather than
-- shadowing the whole autoload file, so job-spawning code etc. stays as
-- upstream ships it.
local function patch_root_dir()
  -- Vim only allows :function! to redefine an autoload-named function
  -- outside its matching autoload file once that function has already been
  -- defined by the real autoload load. Force that load first.
  vim.cmd("silent! call gitmessenger#git#root_dir(getcwd())")

  vim.cmd([[
    function! gitmessenger#git#root_dir(from) abort
      let sep = has('win32') ? '\' : '/'
      let from = fnameescape(fnamemodify(a:from, ':p'))
      if from[-1:] ==# sep
        let from = from[:-2]
      endif

      let dir = finddir('.git', from . ';')
      let file = findfile('.git', from . ';')
      if dir ==# '' && file ==# ''
        return ''
      endif
      let dir = dir ==# '' ? '' : fnamemodify(dir, ':p')
      let file = file ==# '' ? '' : fnamemodify(file, ':p')
      let dotgit = len(dir) > len(file) ? dir : file

      " Anchor the prefix check on a path separator so "/path/to/.git" does
      " not falsely match "/path/to/.github/...".
      let dotgit_with_sep = dotgit[-1:] ==# sep ? dotgit : dotgit . sep
      if stridx(from . sep, dotgit_with_sep) == 0
        return ''
      endif

      if dotgit[-1:] ==# sep
        let dotgit = dotgit[:-2]
      endif
      return fnamemodify(dotgit, ':h')
    endfunction
  ]])
end

return {
  "rhysd/git-messenger.vim",
  config = function()
    patch_root_dir()

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
