if net session >/dev/null 2>/dev/null; then
  ADMIN="(Admin) "
else
  ADMIN=""
fi
PS1='\[\033]0;${ADMIN}${PWD/#$HOME/\~}\007\]' # window title
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

case $TERM in
  xterm*|rxvt*)
    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
      case "$BASH_COMMAND" in
        *\033]0*)
          # The command is trying to set the title bar as well;
          # this is most likely the execution of $PROMPT_COMMAND.
          # Nested escapes confuse the terminal, so don't output them.
          ;;
        *)
          cmd=${BASH_COMMAND#@(winpty|winpty.exe) }
          cmd=${cmd%% *}
          printf "\e]0;[%s] %s%s\a" "${cmd%.exe}" "${ADMIN}" "${PWD/#$HOME/\~}"
          ;;
      esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
esac

# load aliases, if any
[ -f ~/.alias ] && source ~/.alias

export PATH=~/bin:$PATH
export PS1=$PS1
