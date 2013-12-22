local function home_prompt_filter()
  clink.prompt.value = clink.prompt.value:gsub(os.getenv("USERPROFILE"), "~")
  return false
end

--------------------------------------------------------------------------------
clink.prompt.register_filter(home_prompt_filter)
