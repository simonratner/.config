if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

uru=$(which uru_rt)
if [ -x $uru ]; then eval "$($uru admin install)"; fi
