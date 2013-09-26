" needs to be reset after gui starts
set visualbell t_vb=

"if has('gui_win32') || has('gui_win64')
"  au GUIEnter * silent! call libcallnr('vimtweak.dll', 'EnableCaption', 0)
"endif
