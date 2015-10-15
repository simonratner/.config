local function git_branch_fast()
  local dir = clink.get_cwd()
  local sep = package.config:sub(1, 1)
  local count
  while not clink.is_dir(dir..sep..".git") do
    dir, count = string.gsub(dir, "("..sep..")[^"..sep.."]+$", "")
    if count == 0 then break end
  end
  if clink.is_dir(dir..sep..".git") then
    local f = assert(io.open(dir..sep..".git"..sep.."HEAD", "r"))
    local branch = assert(f:read("*all"))
    f:close()
    branch, count = string.gsub(branch, "ref: refs/heads/(.*)\n", "%1")
    if count == 0 then
      return "(-) " -- detached
    else
      return "("..branch..") "
    end
  end
  return ""
end

local function git_branch()
  -- Based on: http://stackoverflow.com/a/13003854/170413
  for branch in io.popen("git rev-parse --abbrev-ref HEAD 2>nul"):lines() do
    if branch == "HEAD" then
      return "(-) " -- detached
    else
      return "("..branch..") "
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
  clink.prompt.value = "\27[1;33m"..git_branch_fast().."\27[m"..clink.prompt.value
  return false
end

--------------------------------------------------------------------------------
clink.prompt.register_filter(git_prompt_filter)
