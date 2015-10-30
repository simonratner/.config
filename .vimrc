if has('win32') || has('win64')
  let $HOME=$USERPROFILE
endif
" On Windows, vim defaults to $HOME/vimfiles, but .vim is just fine.
set rtp^=$GOROOT/misc/vim
set rtp^=$HOME/.vim
set rtp+=$HOME/.vim/after
set rtp-=$HOME/vimfiles
set rtp-=$HOME/vimfiles/after
set encoding=utf-8

" If Windows shell integration ("Edit with Vim") throws errors about
" missing functions and plugins, change the following registry key:
"   [HKEY_CLASSES_ROOT\*\shell\gvim\command]
"   (default) = "path\to\gvim.exe" --cmd "set rtp+=$USERPROFILE/.vim" "%L"

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = ["vim-javascript", "vim-airline"]
call pathogen#infect()

" Windows terminal config.
let s:winconsole = (has('win32') || has('win64')) && !has('gui_running')
if s:winconsole
  set term=xterm
  " Enable 256 colours.
  let &t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[0;38;5;%dm"
  let &t_Sb="\e[48;5;%dm"
  let &t_Sf="\e[0;38;5;%dm"
  " Enable scroll wheel.
  inoremap <Esc>[62~ <C-X><C-E>
  inoremap <Esc>[63~ <C-X><C-Y>
  inoremap <Esc>[64~ <C-X><C-E>
  inoremap <Esc>[65~ <C-X><C-Y>
  nnoremap <Esc>[62~ <C-E>
  nnoremap <Esc>[63~ <C-Y>
  nnoremap <Esc>[64~ <C-E>
  nnoremap <Esc>[65~ <C-Y>
endif

" No modelines for security reasons [http://www.guninski.com/vim1.html]
set modelines=0
set nocompatible
set secure              " don't allow FS modifications in CWD .vimrc/.exrc

" Backups
set directory=$HOME/.vimbak
set backup writebackup
set backupdir=$HOME/.vimbak
set backupskip=/tmp/*,/var/tmp/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

set history=200
set viminfo='100,<0,h,n$HOME/.viminfo   " force .viminfo name on win32

set updatecount=40      " number of characters typed before updating swapfile
set updatetime=1000     " milliseconds before updating swapfile
set suffixes=.bak,~,.o,.swp

set autoindent smartindent    " sane indenting
set tw=0                " disable text autowrap at 80 columns
set ts=2
set sw=2
set sts=2
set expandtab           " make sure that ^T, <<, >>, and the like use spaces
set cinoptions=l1,g0.5s,h0.5s,i2s,+2s,(0,W2s

" Relative line numbers in normal mode
set nu
set rnu
au BufEnter     * :set rnu
au BufLeave     * :set nornu
au WinEnter     * :set rnu
au WinLeave     * :set nornu
au InsertEnter  * :set nornu
au InsertLeave  * :set rnu
au FocusLost    * :set nornu
au FocusGained  * :set rnu

set visualbell t_vb=
set colorcolumn=+2
set noerrorbells
set nowrap
set nohidden            " close the buffer when I close a tab
set noautowrite         " don't automagically write on :next
set lazyredraw          " don't redraw when don't have to
set ttyfast
set showcmd
set showmatch
set noshowmode
set ruler
set incsearch           " incremental search
set hlsearch            " highlight previous search results
set backspace=indent,eol,start
set matchpairs+=<:>               " add < and > to match pairs
set whichwrap+=<,>,[,]            " cursor keys wrap too
set wildmode=longest:full,full    " *wild* mode
set wildignore+=*.o,*~,.lo,*.pyc,*.class,.git
set wildmenu                      " menu has tab completion
let mapleader=','                 " shortcuts start with ,
let maplocalleader=','

set laststatus=2

set foldmethod=marker

syn on                        " enable syntax coloring

filetype on                   " enable filetype detection
filetype indent on            " enable filetype-specific indenting
filetype plugin on            " enable filetype-specific plugins

" Make it so that tabs and trailing spaces are always visible.
set list
set listchars=tab:¬\ ,trail:·,nbsp:·,extends:»,precedes:«
set fillchars+=vert:│

" Customise syntax highlighting (hybrid)
let g:hybrid_use_Xresources = 1  " use first 16 terminal colours
set background=dark
colorscheme hybrid

hi! link SpecialKey Error
hi! link MatchParen Search
syn keyword javascriptCommentTodo NOTE NB contained

" Customise spell highlighting
if version >= 700
  hi SpellBad   guisp=#cc0000 gui=undercurl guifg=NONE guibg=NONE ctermfg=Black ctermbg=DarkRed term=underline cterm=underline
  hi SpellCap   guisp=#cf6a4c gui=undercurl guifg=NONE guibg=NONE ctermfg=Black ctermbg=DarkYellow term=underline cterm=underline
  hi SpellRare  guisp=#cc00cc gui=undercurl guifg=NONE guibg=NONE ctermfg=Black ctermbg=DarkMagenta term=underline cterm=underline
  hi SpellLocal guisp=#cc00cc gui=undercurl guifg=NONE guibg=NONE ctermfg=Black ctermbg=DarkMagenta term=underline cterm=underline
endif

" Customise status line (lightline)
let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlp_modes'] ],
  \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype', 'ctrlp_flags' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive':     'LightLineFugitive',
  \   'filename':     'LightLineFilename',
  \   'fileformat':   'LightLineFileformat',
  \   'filetype':     'LightLineFiletype',
  \   'fileencoding': 'LightLineFileencoding',
  \   'mode':         'LightLineMode',
  \   'ctrlp_modes':  'LightLineCtrlpModes',
  \   'ctrlp_flags':  'LightLineCtrlpFlags',
  \ },
  \ 'mode_map': {
  \   'n'     : 'N',
  \   'c'     : 'C',
  \   'i'     : 'I',
  \   'R'     : 'R',
  \   'v'     : 'V',
  \   'V'     : 'V',
  \   '\<C-v>': 'V',
  \   's'     : 'S',
  \   'S'     : 'S',
  \   '\<C-s>': 'S',
  \   '?'     : ' '
  \ }}
if s:winconsole
  let g:lightline.separator = { 'left': '', 'right': '' }
  let g:lightline.subseparator = { 'left': '│', 'right': '│' }
else
  let g:lightline.separator = { 'left': '', 'right': '' }
  let g:lightline.subseparator = { 'left': '', 'right': '' }
endif

function! LightLineModified()
  return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler' && &readonly ? (s:winconsole ? '[ro]' : '') : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  if fname =~ 'ControlP'
    return g:lightline.ctrlp_item
  endif
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'vimshell' ? vimshell#get_status_string() :
    \  fname != '' ? fname : '[No Name]') .
    \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler' && exists('*fugitive#head')
    let _ = fugitive#head()
    return strlen(_) ? (s:winconsole ? ' '._ : ' '._) : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return expand('%:t') =~ 'ControlP' ? '' : winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return expand('%:t') =~ 'ControlP' ? '' : winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return expand('%:t') =~ 'ControlP' ? '' : winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  if fname =~ 'ControlP'
    call lightline#link('nR'[g:lightline.ctrlp_regex])
    return '^P'
  endif
  return &ft == 'help' ? 'Help' :
       \ &ft == 'vimfiler' ? 'Filer' :
       \ &ft == 'vimshell' ? 'Shell' : lightline#mode()
endfunction

function! LightLineCtrlpModes()
  let fname = expand('%:t')
  if fname =~ 'ControlP'
    return lightline#concatenate([g:lightline.ctrlp_next, g:lightline.ctrlp_prev], 0)
  else
    return ''
  endif
endfunction

function! LightLineCtrlpFlags()
  let fname = expand('%:t')
  if fname =~ 'ControlP'
    return lightline#concatenate([g:lightline.ctrlp_regex, g:lightline.ctrlp_file], 1)
  else
    return ''
  endif
endfunction

" CtrlP configuration
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = (a:regex == 1 ? 'regex' : '')
  let g:lightline.ctrlp_file = a:byfname
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

" Disable quote concealing in json files (vim-json)
let g:vim_json_syntax_conceal = 0

" Load per-project vimrc files
let g:localvimrc_ask = 0

let g:jsx_ext_required = 0

if has("gui_running")
  set lines=40 columns=160
  set linespace=0
  set showtabline=2  " always show tabs

  " On Windows, must be executed before gui is shown (.gvimrc is too late).
  set guioptions=ce
  " Input font settings:
  "   --asterisk=height
  "   --i=serifs_round
  "   --l=serifs_round
  "   --zero=slash
  "   --lineHeight=1.4
  set gfn=InputMono:h10
end

if !has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" ---------------------------------------------------------------------------
" Shorcuts
"

" Avoid accidental scroll after shifted commands
map <S-Up> <Up>
map <S-Down> <Down>
map <S-Left> <Left>
map <S-Right> <Right>
imap <S-Up> <Up>
imap <S-Down> <Down>
imap <S-Left> <Left>
imap <S-Right> <Right>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" yank to end of line
map Y y$
" correct type-o's on exit
nmap q: :q
" toggle buffers
nmap <leader><leader> :b#<cr>
" toggle paste mode
nmap <leader>p :set paste!<cr>
" toggle wrapping
nmap <leader>w :set wrap!<cr>
" toggle list mode
nmap <leader>l :set list!<cr>
" get rid of trailing whitespace
map <leader>d  :%s/[ <Tab>]\+$//<cr>
" insert timestamp at current cursor position
nmap <leader>t  :r! date "+\%Y-\%m-\%d \%T\%Z"<cr>
nmap <leader>T  :-1r! date "+\%Y-\%m-\%d \%T\%Z"<cr>

" fuzzy find
map <leader>f :CtrlP<cr>
map <leader>F :CtrlPClearCache<cr>\|:CtrlP<cr>

" Switch windows easily
nmap <silent> <leader><Tab> <C-w><C-w>

" Map mintty C-Tab/C-S-Tab key codes
set <F13>=[1;5I
set <F14>=[1;6I
map <F13> <C-Tab>
map <F14> <C-S-Tab>
map! <F13> <C-Tab>
map! <F14> <C-S-Tab>
" Switch tabs with ctrl-tab and ctrl-shift-tab like most browsers
nmap <silent> <C-Tab> gt
nmap <silent> <C-S-Tab> gT
" NOTE: abandon insert mode by design
imap <silent> <C-Tab> <C-c>:tabnext<cr>
imap <silent> <C-S-Tab> <C-c>:tabprev<cr>
" C-tab does not work in putty so map F2,F3 as well
nmap <silent> <F3> gt
nmap <silent> <F2> gT
" NOTE: abandon insert mode by design
imap <silent> <F3> <C-c>:tabnext<cr>
imap <silent> <F2> <C-c>:tabprev<cr>

" spelling
nmap <F7> :setlocal invspell<cr>
imap <silent> <F7> <C-O>:silent setlocal invspell<cr>

" Diff with saved version of the file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" ---------------------------------------------------------------------------
" Settings for CommandT
"
let g:CommandTMatchWindowReverse=1

" ---------------------------------------------------------------------------
" Settings for NERDTree
"
map <silent> <F4> :NERDTreeToggle<cr>
let NERDTreeDirArrows=0
let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=1
let NERDTreeShowBookmarks=1
let NERDTreeWinSize=40

" ---------------------------------------------------------------------------
" Settings for VimClojure
"
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1

" ---------------------------------------------------------------------------
"  Automagic Clojure folding on defn's and defmacro's
"
function! ClojureFoldLevel()
  if getline(v:lnum) =~ '^\s*(def\(n\|macro\|method\|test\).*\s'
    return ">1"
  elseif getline(v:lnum) =~ '^\s*(ns\s'
    return ">1"
  elseif getline(v:lnum) =~ '^\s*$'
    let my_cljnum = v:lnum
    let my_cljmax = line("$")

    while (1)
      let my_cljnum = my_cljnum + 1
      if my_cljnum > my_cljmax
        return "<1"
      endif

      let my_cljdata = getline(my_cljnum)

      " If we match an empty line, stop folding
      if my_cljdata =~ '^\s*(def' || my_cljdata =~ '^$'
        return "<1"
      else
        return "="
      endif
    endwhile
  else
    return "="
  endif
endfunction

" Autoload commands:
if has("autocmd")
  autocmd BufRead *.as set filetype=actionscript
  autocmd BufRead *.mxml set filetype=mxml
  autocmd BufRead *.less set filetype=sass
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
  " Use tabs for makefiles
  autocmd FileType make setlocal noet ts=2 sw=2 sts=2
  " Use tabs for go
  autocmd FileType go setlocal noet ts=2 sw=2 sts=2
  " Fold clojure methods
  autocmd FileType clojure setlocal foldexpr=ClojureFoldLevel() foldmethod=expr foldignore=;
endif
