if net session >/dev/null 2>/dev/null; then
  ADMIN="(Admin) "
else
  ADMIN=""
fi
PS1='\[\033]0;${ADMIN}${PWD//[^[:ascii:]]/?}\007\]' # window title
PS1="$PS1"'\[\033[1;31m\]${ADMIN}'
if [ -n "$GIT_EXEC_PATH" ]; then
  PS1="$PS1"'\[\033[1;33m\]'
  PS1="$PS1"'`__git_ps1 "(%s) "`'
fi
PS1="$PS1"'\[\033[0;34m\]\w>\[\033[0m\]\n$ '

# load aliases, if any
[ -f ~/.alias ] && source ~/.alias

export PATH=$PATH:~/bin
export PS1=$PS1
