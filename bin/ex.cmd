@echo off

if exist "%VIMRUNTIME%\vim.exe" goto havevim
if exist "%ProgramFiles(x86)%\Vim\vim82\vim.exe" set VIMRUNTIME=%ProgramFiles(x86)%\Vim\vim82
if exist "%ProgramFiles(x86)%\Vim\vim74\vim.exe" set VIMRUNTIME=%ProgramFiles(x86)%\Vim\vim74
if exist "%ProgramFiles(x86)%\Vim\vim73\vim.exe" set VIMRUNTIME=%ProgramFiles(x86)%\Vim\vim73

:havevim
if exist "%VIMRUNTIME%\vim.exe" (
  "%VIMRUNTIME%\vim.exe" -e %*
) else (
  echo\
  echo Vim not installed, try https://www.vim.org/download.php#pc
)
