@echo off

if exist "%VIMRUNTIME%\vim.exe" goto havevim
if exist "%ProgramFiles%\Vim\vim74\vim.exe" set VIMRUNTIME=%ProgramFiles%\Vim\vim74
if exist "%ProgramFiles(x86)%\Vim\vim74\vim.exe" set VIMRUNTIME=%ProgramFiles(x86)%\Vim\vim74

:havevim
"%VIMRUNTIME%\vim.exe" %*
