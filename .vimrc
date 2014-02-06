command! -nargs=1 CommentOpts /^"OptsGroup:<args>$/+1,/^"EndOptsGroup:<args>$/-1 s/^/"-- / | nohlsearch
command! -nargs=1 UncommentOpts /^"OptsGroup:<args>$/+1,/^"EndOptsGroup:<args>$/-1 s/^"-- // | nohlsearch

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nocompatible
filetype plugin indent on

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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" THESE ARE MY OWN OPTIONS

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

set clipboard=unnamed
set nobackup

set background=light

"OptsGroup:NeoBundle
"-- 
"-- if has('vim_starting')
"--     set runtimepath+=~/.vim/bundle/neobundle.vim/
"-- endif
"-- call neobundle#rc(expand('~/.vim/bundle/'))
"-- filetype on  " For some reason, neobundle#rc breaks the ft detection
"-- source ~/.vim/bundle/bundles.vim
"-- 
"EndOptsGroup:NeoBundle

set path+=src
" Look into src subdirectory (with 'gf' notably)

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

map <M-Right> <C-W>5>
map <M-Left>  <C-W>5<
map <M-Down>  <C-W>5+
map <M-Up>    <C-W>5-

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

map ²² :tab split<Return>
map ²l :tabnext<Return>
map ²h :tabprevious<Return>
map ²k :call MoveTabRight()<Return>
map ²j :call MoveTabLeft()<Return>

map <C-N> :tnext<Return>
map <C-P> :tprevious<Return>

"Quick and dirty call to a build script
map !! :w<Return> :cexpr system("./build.sh")<Return>

set relativenumber "Display lines numbers relatively to current line
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
noremap <silent> !c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> !u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

