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

" SO AS TO USE LaTeX

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Imap_UsePlaceHolders=0

" END: LaTeX settings

map ; :

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

map <C-B>        :buffers<Return>
map <C-Down>     :bnext<Return>
map <C-Up>       :bprevious<Return>
map <Tab><Tab>   :tabnew<Return>
map <Tab><Up>    :tab split +:E<Return>
map <Tab><Down>  :tabclose<Return>
map <Tab><Right> :tabnext<Return>
map <Tab><Left>  :tabprevious<Return>

set number "Display lines numbers
" set ignorecase "Ignore case while searching
set shiftwidth=2
set tabstop=2
set expandtab

set switchbuf=useopen
set autoindent

set linebreak " Do not cut words


" NETRW BROWSER (:E) SETTINGS

let g:netrw_alto = 1 " When opening file with hsplit (o), open file in the bottom window
let g:netrw_altv = 1 " When opening file with vsplit (v), open file in the right window
let g:netrw_list_hide = '^\.[^(\.$)],.*\~$,.*\~\*$,.*\.pyc$,.*\.o$,.*\.hi$,.*\.class$'

" END OF NETRW BROWSER SETTINGS

au BufRead,BufNewFile *.pde setf cpp
au BufRead,BufNewFile [sS][cC]onstruct* setf python

au BufRead,BufNewFile *.hsc,*.gc setf haskell
au BufRead,BufNewFile *.py setlocal shiftwidth=4
au BufRead,BufNewFile *.py setlocal tabstop=4

au BufRead,BufNewFile *.pl setf prolog

au BufRead,BufNewFile *.oz,*.ozg setf oz


au FileType haskell,vhdl,ada let b:comment_leader = '-- '
au FileType vim let b:comment_leader = '" '
au FileType c,cpp,java let b:comment_leader = '// '
au FileType sh,make,python let b:comment_leader = '# '
au FileType tex let b:comment_leader = '% '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

