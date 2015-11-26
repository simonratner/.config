if net session >/dev/null 2>/dev/null; then
  ADMIN="(Admin) "
else
  ADMIN=""
fi
PS1='\[\033]0;${ADMIN}${PWD//[^[:ascii:]]/?}\007\]' # window title
PS1="$PS1"'\[\033[1;31m\]${ADMIN}'
# git prompt {{{
GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
if test -f "$COMPLETION_PATH/git-prompt.sh"
then
  . "$COMPLETION_PATH/git-completion.bash"
  . "$COMPLETION_PATH/git-prompt.sh"
  PS1="$PS1"'\[\033[1;33m\]'
  PS1="$PS1"'`__git_ps1 "(%s) "`'
fi
# }}}
PS1="$PS1"'\[\033[0;34m\]\w>\[\033[0m\]\n$ '

# load aliases, if any
[ -f ~/.alias ] && source ~/.alias

export PATH=$PATH:~/bin
export PS1=$PS1
