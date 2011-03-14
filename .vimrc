set guioptions-=M  "must be executed before gui is shown to take effect

set nocompatible

" Backups:
set directory=$HOME/.vimbak
set backup writebackup
set backupdir=$HOME/.vimbak
set backupskip=/tmp/*,/var/tmp/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set history=200          " Store last 200 commands as history.
" Store in .viminfo: marks for 50 files, 200 lines of registers.
set viminfo='50,\"200
set updatecount=40       " Number of characters typed before updating swapfile.
set updatetime=1000      " Milliseconds before updating swapfile.
set suffixes=.bak,~,.o,.swp

" Attempt to get sane indenting:
set autoindent
set si
set tw=0  " disable text autowrap at 80 columns
set ts=2
set sw=2
set sts=2
set expandtab            " Make sure that ^T, <<, >>, and the like use spaces.
set cinoptions=l1,g0.5s,h0.5s,i2s,+2s,(0,W2s
" Make sure that the tab key actually inserts a tab.
"imap <TAB> <C-V><TAB>

" Don't mess with my terminal unless I tell you to!
set norestorescreen

" Nice helper stuff:
set showmode
set showmatch
set ruler
set showcmd
set incsearch
set hlsearch             " Highlight previous search results
set backspace=indent,eol,start
set whichwrap=<,>,[,]
set laststatus=2
" filepath [modified][buffer][filetype,ro] line,col-virtualcol,byteoffset
set statusline=%<%f%=\ %3.3m[%n][%Y%R]\ %{fugitive#statusline()}\ \ %-35(%3l,%c%V,%o\ \ %P\ (%L)%)%10(%b\ 0x%B\ %)

" Tab-complete filenames to longest unambiguous match and present menu:
" set wildmenu wildmode=longest:full
set wildmenu

"se exrc                " Load .vimrc/.exrc file from CWD.  (Danger!)
set secure               " Don't allow FS modifications in CWD .vimrc/.exrc.

" Enable syntax coloring
syntax on
set background=dark
" xterm256 only
" colorscheme moria256

" So we can see tabs and trailing spaces.
hi SpecialKey cterm=none ctermbg=DarkBlue ctermfg=White

" Make it so that tabs and trailing spaces are always visible:
" (Relys on syntax highlighting to turn them yellow.)
set list
set listchars=tab:\ \ ,trail:\ ,extends:»,precedes:«

" Some nice shortcuts:
" Yank to end of line.
map Y y$
" Reformat lines.
map Q gq
" Enter/leave paste mode.
map gp :set invpaste<CR>:set paste?<CR>
" Edit alternate file.
map gg :e#<CR>
" Turn on word-wrapping.
map gw :se tw=75<CR>
" Execute contents of register a.
map \ @a
" Get rid of trailing whitespace.
map gc :%s/[ <Tab>]\+$//<CR>

" Fix paragraph movement ('{' and '}') to ignore whitespace.
" (This mostly works correctly, except when used in selection ('V') mode,
"  where the last search is changed.)
nmap { ?\S?;?^\s*$<CR>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:nohlsearch<CR>:<CR>
omap { ?\S?;?^\s*$<CR>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:nohlsearch<CR>:<CR>
vmap { ?\S?;?^\s*$<CR>
nmap } /\S/;/^\s*$<CR>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:nohlsearch<CR>:<CR>
omap } /\S/;/^\s*$<CR>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:nohlsearch<CR>:<CR>
vmap } /\S/;/^\s*$<CR>

" move to next/previous buffer
"map <silent> <F2> :bN!<CR>
"map <silent> <F3> :bn!<CR>
"imap <silent> <F2> <C-O>:bN!<CR>
"imap <silent> <F3> <C-O>:bn!<CR>

" tab navigation like firefox
map <silent> <C-S-tab> :tabprevious<cr>
map <silent> <C-tab> :tabnext<cr>
imap <silent> <C-S-tab> <C-O>:tabprevious<cr>
imap <silent> <C-tab> <C-O>:tabnext<cr>
" C-tab does not work in putty so map F2,F3 as well
map <silent> <F2> :tabprevious<cr>
map <silent> <F3> :tabnext<cr>
imap <silent> <F2> <C-O>:tabprevious<cr>
imap <silent> <F3> <C-O>:tabnext<cr>
" C-F2,F3 cycles through quickfix list
map <silent> <C-F2> :cp<cr>
map <silent> <C-F3> :cn<cr>
imap <silent> <C-F2> <C-O>:cp<cr>
imap <silent> <C-F3> <C-O>:cn<cr>

" spelling
map <F7> :setlocal invspell<CR>
imap <silent> <F7> <C-O>:silent setlocal invspell<CR>

set pastetoggle=<F4>

" Autoload commands:
if has("autocmd")
  autocmd BufRead *.as set filetype=actionscript
  autocmd BufRead *.mxml set filetype=mxml
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
  " Use tabs for makefiles
  autocmd FileType make setlocal noet ts=8 sw=8 sts=8
endif
