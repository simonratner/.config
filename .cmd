@echo off

rem This file configures win32 cmd.exe profile.
rem
rem Add the following, as a (String) value:
rem    call %USERPROFILE%/.cmd
rem
rem to these registry keys:
rem    HKEY_CURRENT_USER\Software\Microsoft\Command Processor\Autorun
rem    HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\Command Processor\Autorun

rem Aliases
doskey cd~=cd %USERPROFILE%
doskey cd..=cd ..
doskey cd...=cd ../..
doskey cd....=cd ../../..
doskey la=ls -la $*
doskey ll=ls -l $*
doskey gri=grep --color=auto -ri $*
doskey grep=grep --color=auto $*
doskey config=git --git-dir=%USERPROFILE%/.config.git --work-tree=%USERPROFILE% $*
doskey vi=vim $*
doskey vimdiff=vim -d $*

rem Requires ansicon or a terminal that supports ansi escapes.
prompt $E[0;34m$P$+$G$E[1;37m$S$_$$$S

rem Inject readline command processor.
"C:\Lib\clink\clink" inject --profile "%USERPROFILE%\.clink"
