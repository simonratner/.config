if has('win32') || has('win64')
  let $HOME=$USERPROFILE
endif
" On Windows, vim defaults to $HOME/vimfiles,
" but Vista+ supports .filenames just fine.
set rtp+=$HOME/.vim
set rtp+=$GOROOT/misc/vim
set encoding=utf-8

" If Windows shell integration ("Edit with Vim") throws errors about
" missing functions and plugins, change the following registry key:
"   [HKEY_CLASSES_ROOT\*\shell\gvim\command]
"   (default) = "path\to\gvim.exe" --cmd "set rtp+=$USERPROFILE/.vim" "%L"

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
call pathogen#infect()

" CtrlP configuration
let g:ctrlp_map = ""
let g:ctrlp_status_func = {
  \ 'main': 'CtrlP_Statusline_1',
  \ 'prog': 'CtrlP_Statusline_2',
  \ }
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']

" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"            a:1    a:2      a:3       a:4  a:5   a:6  a:7
fu! CtrlP_Statusline_1(...)
  let focus = '['.a:1.']'
  let fname = '['.a:2.']'
  let regex = a:3 ? '[regex]' : ''
  let mode = ' '.a:5.' '
  let marked = ' '.a:7.' '
  " Return the full statusline
  retu getcwd().' %=%< '.focus.fname.regex.mode.marked
endf

" Arguments: len
"            a:1
fu! CtrlP_Statusline_2(...)
  let len = ' '.a:1.' '
  " Return the full statusline
  retu getcwd().' %=%< '.len
endf

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

" relative line numbers in normal mode
set rnu
au BufEnter     * :set rnu
au BufLeave     * :set nu
au WinEnter     * :set rnu
au WinLeave     * :set nu
au InsertEnter  * :set nu
au InsertLeave  * :set rnu
au FocusLost    * :set nu
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

" filepath [modified][buffer][filetype,ro] line,col-virtualcol,byteoffset
"set statusline=%<%f%=\ %3.3m[%n][%Y%R]\ %{fugitive#statusline()}\ \ %-35(%3l,%c%V,%o\ \ %P\ (%L)%)%10(%b\ 0x%B\ %)
set statusline=%<%f%=\ %3.3m[%n][%Y%R]\ \ %-35(%3l,%c%V,%o\ \ %P\ (%L)%)%10(%b\ 0x%B\ %)
set laststatus=2

set foldmethod=marker

syn on                        " enable syntax coloring
                              " extra comment tags
syn keyword vimTodo                 NOTE NB contained
syn keyword javaScriptCommentTodo   NOTE NB contained

filetype on                   " enable filetype detection
filetype indent on            " enable filetype-specific indenting
filetype plugin on            " enable filetype-specific plugins

" Make it so that tabs and trailing spaces are always visible.
set list
set listchars=tab:¬\ ,trail:·,nbsp:·,extends:»,precedes:«
set fillchars+=vert:│

let g:jellybeans_overrides = {
\    'Cursor':  {'guifg': '404040', 'guibg': 'e8e8d3'},
\    'Visual':  {'ctermfg': 'White', 'ctermbg': 'DarkGrey'},
\    'LineNr':  {'ctermfg': 'DarkGrey', 'ctermbg': 'Black'},
\    'ColorColumn': {'guibg': '111111', 'ctermbg': 'Black', '256ctermbg': 234},
\    'NonText': {'guifg': '605958', 'guibg': '1c1c1c',
\                  'ctermfg': 'DarkGrey', 'ctermbg': 'Black', '256ctermbg': 234},
\    'VertSplit': {'guifg': '403c41', 'guibg': '1c1c1c',
\                  'ctermfg': 'DarkGrey', 'ctermbg': 'Black', '256ctermbg': 234, '256ctermfg': 238},
\    'StatusLine': {'guifg': 'e8e8d3', 'guibg': '403c41',
\                   'ctermfg': 'White', 'ctermbg': 'DarkGrey', '256ctermbg': 236},
\    'StatusLineNC': {'guifg': '808080', 'guibg': '403c41',
\                     'ctermfg': 'Grey', 'ctermbg': 'DarkGrey', '256ctermbg': 236},
\
\    'MatchParen': {'guifg': 'f0a0c0', 'guibg': '302028',
\                   'ctermfg': 'Magenta', 'ctermbg': 'DarkMagenta',
\                   'attr': 'underline'},
\
\    'Comment': {'guifg': '605958', 'ctermfg': 'DarkGrey', 'attr': 'italic'},
\    'Todo':    {'guifg': '404040', 'guibg': 'fad07a',
\                'ctermfg': 'Black', 'ctermbg': 'Yellow',
\                'attr': 'italic'},
\    'Search': {'ctermfg': 'Magenta', 'ctermbg': 'DarkMagenta'},
\    'SpecialKey': {'guifg': 'cc0000', 'ctermfg': 'DarkRed'},
\}

set background=dark
colorscheme jellybeans

" Customise spell undercurl colours
if version >= 700
  hi SpellBad   guisp=#cc0000 gui=undercurl guifg=NONE guibg=NONE ctermfg=Black ctermbg=DarkRed term=underline cterm=underline
  hi SpellCap   guisp=#cf6a4c gui=undercurl guifg=NONE guibg=NONE ctermfg=Black ctermbg=DarkYellow term=underline cterm=underline
  hi SpellRare  guisp=#cc00cc gui=undercurl guifg=NONE guibg=NONE ctermfg=Black ctermbg=DarkMagenta term=underline cterm=underline
  hi SpellLocal guisp=#cc00cc gui=undercurl guifg=NONE guibg=NONE ctermfg=Black ctermbg=DarkMagenta term=underline cterm=underline
endif
hi! StatusLine cterm=NONE term=NONE
hi! StatusLineNC cterm=NONE term=NONE
hi! link SignColumn LineNr

" Customise airline (vim-airline)
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '│'
let g:airline_right_alt_sep = '│'
let g:airline_linecolumn_prefix = '¶'
if (has('win32') || has('win64')) && !has('gui_running')
  let g:airline_branch_prefix = ''
  let g:airline_readonly_symbol = 'RO'
else
  let g:airline_branch_prefix = '⌥'
  let g:airline_readonly_symbol = '⌀'
endif
call airline#parts#define_accent('mode', 'none')
call airline#parts#define_raw('pos', '%3p%% %{g:airline_symbols.linenr} %10(%l,%c%V%)')
call airline#parts#define_raw('char', '%4(0x%B%)')
let g:airline_section_z = airline#section#create_right(['pos', 'char'])

" Disable quote concealing in json files (vim-json)
let g:vim_json_syntax_conceal = 0

" Load per-project vimrc files
let g:localvimrc_ask = 0

if has("gui_running")
  set lines=40 columns=160
  set linespace=0
  set showtabline=2  " always show tabs

  " On Windows, must be executed before gui is shown (.gvimrc is too late).
  set guioptions=ce

  if has("mac")
    set gfn=Meslo\ LG\ S\ Regular\ for\ Powerline:h13
    "set gfn=Menlo_Regular:h13
  else
    set gfn=Meslo_LG_S:h10
    "set gfn=Consolas:h9:cANSI
  endif
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
map <leader>F :CtrlPReload<cr>\|:CtrlP<cr>

" Switch windows easily
nmap <silent> <leader><Tab> <C-w><C-w>

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
let NERDTreeDirArrows=1
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
