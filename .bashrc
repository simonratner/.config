# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

case $(uname -a) in
  *icrosoft*)
    wsl=yes
    if net.exe session >/dev/null 2>/dev/null; then
      wsl_ps1="Administrator: "
    else
      wsl_ps1=""
    fi
    ;;
esac

function __aws_ps1() {
  if [[ $AWS_VAULT ]] && [[ $AWS_SESSION_EXPIRATION ]]; then
    local DIFF=$((($(date -d "$AWS_SESSION_EXPIRATION" +%s) - $(date +%s))))
    if [[ "$DIFF" -le 0 ]]; then
      printf "$1" "$AWS_VAULT expired"
    else
      printf "$1" "$AWS_VAULT $(($DIFF/60))m$(($DIFF%60))s"
    fi
  fi
}

if [ "$color_prompt" = yes ]; then
  PS1="\[\033[0;31m\]${wsl_ps1}${debian_chroot:+($debian_chroot) }"'$(__aws_ps1 "(%s) ")\[\033[0;33m\]$(__git_ps1 "(%s) ")\[\033[0;34m\]\w>\[\033[0m\]\n$ '
else
  PS1="${wsl_ps1}${debian_chroot:+($debian_chroot)}"'$(__aws_ps1 "(%s) ")$(__git_ps1 "(%s) ")\w>\n$ '
fi

# If this is an xterm, set the window title
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${wsl_ps1}${debian_chroot:+($debian_chroot)}\w\a\]$PS1"
    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    function show_command_in_title_bar {
      case "$BASH_COMMAND" in
        *\033]0*)
          # The command is trying to set the title bar as well;
          # this is most likely the execution of $PROMPT_COMMAND.
          # Nested escapes confuse the terminal, so don't output them.
          ;;
        *)
          cmd=${BASH_COMMAND#@(winpty|winpty.exe) }
          cmd=${cmd%% *}
          printf "\e]0;%s[%s] %s\a" "${wsl_admin:+[$wsl_admin] }" "${cmd%.exe}" "${debian_chroot:+($debian_chroot)}${PWD/#$HOME/\~}"
          ;;
      esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
  *)
    ;;
esac
unset color_prompt force_color_prompt wsl wsl_ps1

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Bare git repo for storing config files.
function config {
  git --git-dir=$HOME/.config.git --work-tree=$HOME "$@"
}

# Highlight function.  Use like so:
#   cat $file | highlight red "foo" | highlight green "bar"
function highlight() {
  declare -A fg_color_map
  fg_color_map[black]=30
  fg_color_map[red]=31
  fg_color_map[green]=32
  fg_color_map[yellow]=33
  fg_color_map[blue]=34
  fg_color_map[magenta]=35
  fg_color_map[cyan]=36

  fg_c=$(echo -e "\e[1;${fg_color_map[$1]}m")
  c_rs=$'\e[0m'
  sed -u s"/$2/$fg_c\0$c_rs/g"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install ruby runtime picker
uru=$(which uru_rt)
if [ -x "$uru" ]; then
  eval "$($uru admin install)"
fi

# Install br shell function, if exists
if [ -f "$HOME/.config/broot/launcher/bash/br" ]; then
  source "$HOME/.config/broot/launcher/bash/br"
fi
