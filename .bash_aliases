# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  export LS_COLORS="$LS_COLORS:ow=1;33"
  #alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'
fi

alias ls='ls -F -I[Nn][Tt][Uu][Ss][Ee][Rr]* --color=auto --show-control-chars'
alias la='ls -A'
alias ll='ls -alF'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# enable colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias jqt="jq -r '(map(keys) | add | unique) as \$cols | map(. as \$row | \$cols | map(\$row[.])) as \$rows | \$cols, \$rows[] | @tsv'"
alias jqc="jq -r '(map(keys) | add | unique) as \$cols | map(. as \$row | \$cols | map(\$row[.])) as \$rows | \$cols, \$rows[] | @csv'"

alias vi='vim'

if [ -n "$MSYSTEM" ]; then
  alias gr='winpty gradlew.bat'
  alias heroku='winpty heroku.bat'
  alias pidcat='python $(which pidcat.py)'

  case "$TERM" in
  xterm*)
    # The following programs are known to require a Win32 console
    # for interactive usage, so launch them through `winpty` when
    # running inside `msys2`.
    for name in node python vagrant
    do
      alias $name="winpty $name.exe"
    done
    alias npm="winpty npm.cmd"
    # The following ruby stripts must be run via the batch file,
    # rather than the shell script which assumes a cygwin env.
    for name in bundle bundler gem rake rackup
    do
      alias $name="$name.bat"
    done
    ;;
  esac
else
  alias gr='./gradlew'
fi
