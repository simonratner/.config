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
prompt $E[0;1;30m[$D$S$T]$E[0m$S$+$E[0;34m$P$G$E[0m$_$$$S

rem Run ssh-agent with a fixed socket address.
if not defined SSH_AUTH_SOCK set SSH_AUTH_SOCK=/tmp/ssh-agent
ssh-agent -a %SSH_AUTH_SOCK% 2>nul

rem Inject readline command processor.
"C:\Lib\clink\clink" inject --profile "%USERPROFILE%/.clink"
