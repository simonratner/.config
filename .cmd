@echo off

rem This file configures win32 cmd.exe profile.
rem
rem Add the following:
rem    call %USERPROFILE%/.cmd
rem
rem to this registry key:
rem    HKEY_CURRENT_USER\Software\Microsoft\Command Processor\Autorun

rem Aliases
doskey cd~=cd %USERPROFILE%
doskey cd.=cd ..
doskey cd..=cd ../..
doskey cd...=cd ../../..
doskey ll=ls -l $*
doskey la=ls -la $*

rem Node shortcuts
doskey sails="node_modules/.bin/sails.cmd" $*
doskey mocha="node_modules/.bin/mocha.cmd" $*

rem Requires ansicon or a terminal that supports ansi escapes.
prompt $E[0;1;30m[$D$S$T]$E[0m$S$+$E[0;34m$P$E]9;3;"$P"$E\$G$E[0m$_$$$S

rem Run ssh-agent, if not already running.
ps | awk "/ssh-agent/ { print $1 }" > C:\Temp\ssh-agent-pid
set SSH_AUTH_SOCK=C:\Temp\ssh-agent-sock
set SSH_AGENT_PID=
set /p SSH_AGENT_PID=< C:\Temp\ssh-agent-pid
if not defined SSH_AGENT_PID (
  rm %SSH_AUTH_SOCK%
  ssh-agent -a %SSH_AUTH_SOCK%
)

rem Inject readline command processor.
"C:\Lib\clink\clink" inject --profile "%USERPROFILE%/.clink"
