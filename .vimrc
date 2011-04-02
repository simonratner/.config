" On Windows, vim defaults to $HOME/vimfiles,
" but Vista+ supports .filenames just fine.
set rtp+=$HOME/.vim

" No modelines for security reasons [http://www.guninski.com/vim1.html]
set modelines=0
set nocompatible
set secure              " don't allow FS modifications in CWD .vimrc/.exrc

" Backups
set directory=$HOME/.vimbak
set backup writebackup
set backupdir=$HOME/.vimbak
set backupskip=/tmp/*,/var/tmp/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

" Force .viminfo filename, store marks for 50 files, 200 lines of registers.
set viminfo='50,\"200,n$HOME/.viminfo

set history=200         " store last 200 commands as history
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

set noerrorbells
set nowrap
set nohidden            " close the buffer when I close a tab
set noautowrite         " don't automagically write on :next
set lazyredraw          " don't redraw when don't have to
set ttyfast
set showcmd
set showmode
set showmatch
set ruler
set incsearch           " incremental search
set hlsearch            " highlight previous search results
set backspace=indent,eol,start
set matchpairs+=<:>           " add < and > to match pairs
set whichwrap+=<,>,[,]        " cursor keys wrap too
set wildmode=longest:full     " *wild* mode
set wildignore+=*.o,*~,.lo    " ignore object files
set wildmenu                  " menu has tab completion
let mapleader=','             " shortcuts start with ,
let maplocalleader=','

" filepath [modified][buffer][filetype,ro] line,col-virtualcol,byteoffset
"set statusline=%<%f%=\ %3.3m[%n][%Y%R]\ %{fugitive#statusline()}\ \ %-35(%3l,%c%V,%o\ \ %P\ (%L)%)%10(%b\ 0x%B\ %)
set statusline=%<%f%=\ %3.3m[%n][%Y%R]\ \ %-35(%3l,%c%V,%o\ \ %P\ (%L)%)%10(%b\ 0x%B\ %)
set laststatus=2


syntax on                     " enable syntax coloring
filetype on                   " enable filetype detection
filetype indent on            " enable filetype-specific indenting
filetype plugin on            " enable filetype-specific plugins

" Make it so that tabs and trailing spaces are always visible.
set list
set listchars=tab:»\ ,trail:·,extends:»,precedes:«

set background=dark

if !has("gui_running")
  " So we can see tabs and trailing spaces.
  hi SpecialKey cterm=none ctermfg=Red
end

if has("gui_running")
  " colorscheme moria
  " hi SpecialKey guibg=#3d5074

  let rdark_current_line = 1
  colorscheme rdark

  set lines=48 columns=160
  set showtabline=2  " always show tabs

  " On Windows, must be executed before gui is shown (.gvimrc is too late).
  set guioptions=c
  set gfn=Consolas:h9:cANSI
end

" ---------------------------------------------------------------------------
" Shorcuts
"

" yank to end of line
map Y y$
" correct type-o's on exit
nmap q: :q
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>
" toggle wrapping
nmap <LocalLeader>ww :set wrap!<cr>
" toggle list mode
nmap <LocalLeader>ll :set list!<cr>
" toggle taglist on and off
nmap <LocalLeader>tt :Tlist<cr>

" change directory to that of current file
nmap <LocalLeader>cd :cd%:p:h<cr>
" change local directory to that of current file
nmap <LocalLeader>lcd :lcd%:p:h<cr>
" open all folds
nmap <LocalLeader>o  :%foldopen!<cr>
" close all folds
nmap <LocalLeader>c  :%foldclose!<cr>
" return to syntax folding with a big foldcolumn
nmap <LocalLeader>sf :set foldcolumn=6 foldmethod=syntax<cr>
" get rid of trailing whitespace
map <LocalLeader>d   :%s/[ <Tab>]\+$//<CR>

" Switch tabs with ctrl-tab and ctrl-shift-tab like most browsers
map <silent> <C-Tab> gt
map <silent> <C-S-Tab> gT
" C-tab does not work in putty so map F2,F3 as well
map <silent> <F2> :tabprevious<cr>
map <silent> <F3> :tabnext<cr>

" Diff with saved version of the file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Fix paragraph movement ('{' and '}') to ignore whitespace. This mostly
" works, except in selection ('V') mode, where the last search is changed.
nmap { ?\S?;?^\s*$<CR>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:nohlsearch<CR>:<CR>
omap { ?\S?;?^\s*$<CR>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:nohlsearch<CR>:<CR>
vmap { ?\S?;?^\s*$<CR>
nmap } /\S/;/^\s*$<CR>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:nohlsearch<CR>:<CR>
omap } /\S/;/^\s*$<CR>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:nohlsearch<CR>:<CR>
vmap } /\S/;/^\s*$<CR>


" spelling
map <F7> :setlocal invspell<CR>
imap <silent> <F7> <C-O>:silent setlocal invspell<CR>

" Settings for VimClojure
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1

" ---------------------------------------------------------------------------
"  Clojure comment blocks
"
map <Leader>; :call ClojureCommentUncomment()<CR>
function! ClojureCommentUncomment()
  let search_saved = @/
  if getline('.') =~ '^;'
    s/^;//  " remove ';' at beginning of line
  else
    s/^/;/  " insert ';' at beginning of line
  endif
  let @/ = search_saved
endfunction

" ---------------------------------------------------------------------------
"  Automagic Clojure folding on defn's and defmacro's
"
function ClojureFoldLevel()
  if getline(v:lnum) =~ '^\s*(def\w\+.*\s'
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
      if my_cljdata =~ '^$'
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
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
  " Use tabs for makefiles
  autocmd FileType make setlocal noet ts=8 sw=8 sts=8
  " Fold clojure methods
  autocmd FileType clojure setlocal foldexpr=ClojureFoldLevel() foldmethod=expr foldignore=;
endif
