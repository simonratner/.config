local function home_prompt_filter()
  clink.prompt.value = clink.prompt.value:gsub(os.getenv("USERPROFILE"):gsub("(.)",
    function(c)
      return "["..c:upper()..c:lower().."]"
    end), "~")
  return false
end

--------------------------------------------------------------------------------
clink.prompt.register_filter(home_prompt_filter)
