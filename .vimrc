command! -nargs=1 CommentOpts /^"OptsGroup:<args>$/+1,/^"EndOptsGroup:<args>$/-1 s/^/"-- / | nohlsearch
command! -nargs=1 UncommentOpts /^"OptsGroup:<args>$/+1,/^"EndOptsGroup:<args>$/-1 s/^"-- // | nohlsearch

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" THESE ARE MY OWN OPTIONS

set clipboard=unnamed
set nobackup

set background=light

"OptsGroup:NeoBundle

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle "Shougo/neobundle.vim"
NeoBundle "Shougo/vimproc"
NeoBundle "Shougo/neocomplcache"
let g:neocomplcache_enable_at_startup = 1  " If too heavy, disable and use manually :NeoComplCacheEnable

"NeoBundle "scrooloose/syntastic"
"let g:syntastic_quiet_warnings = 1

NeoBundle "kien/ctrlp.vim"
let g:ctrlp_map = '!f'
map !t :CtrlPTag<Return>
map !b :CtrlPBuffer<Return>
map !j :CtrlPMRUFiles<Return>
let g:ctrlp_dotfiles=0
let g:ctrlp_working_path_mode=0
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_match_window_reversed=0

NeoBundle "majutsushi/tagbar"
map !e :TagbarToggle<Return>

NeoBundle "Lokaltog/vim-powerline"
set laststatus=2  " Always display statusline
set t_Co=256

NeoBundle "godlygeek/tabular"
command! -nargs=1 Tabop Tabular /\(\s\|\a\|[()[\]{}]\)\zs<args>\ze\(\s\|\a\|[()[\]{}]\)

NeoBundle "SirVer/ultisnips"

"NeoBundle "ironcamel/vimchat"

" Haskell-related plugins

NeoBundle "eagletmt/ghcmod-vim"
let g:ghcmod_ghc_options = split($GHC_STATICOPTS)

NeoBundle "ujihisa/neco-ghc"

NeoBundle "dag/vim2hs"
NeoBundle "kana/vim-filetype-haskell"

NeoBundle "vim-scripts/VimClojure"

NeoBundle "vim-scripts/n3.vim"

NeoBundle "vim-scripts/VimClojure"

"EndOptsGroup:NeoBundle

"OptsGroup:LaTeX

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"EndOptsGroup:LaTeX

set noequalalways  " Windows won't get resized when one is closed

map  <Up>   g<Up>
map  <Down> g<Down>
map  <Home> g<Home>
map  <End>  g<End>
imap <Home> <Esc>g<Home>i
imap <End>  <Esc>g<End>i

map <M-Right> <C-W>l
map <M-Left>  <C-W>h
map <M-Down>  <C-W>j
map <M-Up>    <C-W>k

" To move the tabs
function MoveTabLeft()
   let tab_number = tabpagenr() - 1
   if tab_number == 0
      execute "tabm" tabpagenr('$') - 1
   else
      execute "tabm" tab_number - 1
   endif
endfunction

function MoveTabRight()
   let tab_number = tabpagenr() - 1
   let last_tab_number = tabpagenr('$') - 1
   if tab_number == last_tab_number
      execute "tabm" 0
   else
      execute "tabm" tab_number + 1
   endif
endfunction

map ²<Up>           :tab split<Return>
map ²<Down>         :tabclose<Return>
map ²<Right>        :tabnext<Return>
map ²<Left>         :tabprevious<Return>
map ²²<Right> :call MoveTabRight()<Return>
map ²²<Left>  :call MoveTabLeft()<Return>

"Quick and dirty call to a build script
map !! :w<Return> :cexpr system("./build.sh")<Return>

set number "Display lines numbers
set ignorecase "Ignore case while searching
set shiftwidth=4
set tabstop=4
set expandtab

set switchbuf=useopen
set autoindent

set linebreak " Do not cut words

"OptsGroup:NetRW

let g:netrw_alto = 1 " When opening file with hsplit (o), open file in the bottom window
let g:netrw_altv = 1 " When opening file with vsplit (v), open file in the right window
let g:netrw_list_hide = '^\.[^(\.$)],.*\~$,.*\~\*$,.*\.pyc$,.*\.o$,.*\.hi$,.*\.class$'

"EndOptsGroup:NetRW

" Commenting lines out:
au FileType haskell,vhdl,ada let b:comment_leader = '-- '
au FileType vim let b:comment_leader = '" '
au FileType c,cpp,java let b:comment_leader = '// '
au FileType sh,make,python let b:comment_leader = '# '
au FileType tex let b:comment_leader = '% '
au FileType lisp,scheme,clojure let b:comment_leader = '; '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

