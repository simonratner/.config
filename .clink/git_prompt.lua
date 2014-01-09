local function git_branch()
  -- Based on: http://stackoverflow.com/a/13003854/170413
  for branch in io.popen("git rev-parse --abbrev-ref HEAD 2>nul"):lines() do
    if branch == "HEAD" then
      return "(-)" -- detached
    else
      return "("..branch..")"
    end
  end
  return ""
end

local function git_dirty()
  for status in io.popen("git diff --numstat --ignore-submodules HEAD 2>nul"):lines() do
    if status then
      return "±"
    end
  end
  return ""
end

local function git_prompt_filter()
  clink.prompt.value = clink.prompt.value:gsub(">", "> \27[1;33m"..git_branch().."\27[1;31m"..git_dirty().."\27[0m")
  return false
end

--------------------------------------------------------------------------------
clink.prompt.register_filter(git_prompt_filter)
