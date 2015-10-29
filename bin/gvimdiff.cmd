@echo off

if exist "%VIMRUNTIME%\gvim.exe" goto havevim
if exist "%ProgramFiles%\Vim\vim74\gvim.exe" set VIMRUNTIME=%ProgramFiles%\Vim\vim74
if exist "%ProgramFiles(x86)%\Vim\vim74\gvim.exe" set VIMRUNTIME=%ProgramFiles(x86)%\Vim\vim74

:havevim
start /b "" "%VIMRUNTIME%\gvim.exe" -d %*
