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
map !e :TagbarOpenAutoClose<Return>
let g:tagbar_left=1
let g:tagbar_sort=0

NeoBundle "Lokaltog/vim-powerline"
set laststatus=2  " Always display statusline
set t_Co=256

NeoBundle "godlygeek/tabular"
command! -nargs=1 Tabop Tabular /\(\s\|\a\|[()[\]{}]\)\zs<args>\ze\(\s\|\a\|[()[\]{}]\)

NeoBundle "SirVer/ultisnips"

"NeoBundle "ironcamel/vimchat"

" Haskell-related plugins

"let g:ghcmod_ghc_options = split($GHC_STATICOPTS)
NeoBundle "bitc/vim-hdevtools"

NeoBundle "bitc/lushtags"

NeoBundle "ujihisa/neco-ghc"

NeoBundle "dag/vim2hs"
let g:haskell_conceal_enumerations = 0
let g:haskell_autotags = 1  " Use this way, requires 'fast-tags' to be installed and in $PATH
" NeoBundle "kana/vim-filetype-haskell"

" Lisp-related plugins

NeoBundle "jpalardy/vim-slime"
let g:slime_target="tmux"

NeoBundle "https://bitbucket.org/kovisoft/slimv"
let g:slimv_disable_clojure=1
let g:slimv_disable_scheme=1
let g:slimv_impl='sbcl'
let g:lisp_rainbow=1
au BufWinEnter REPL inoremap <buffer> <C-W> <Esc><C-W>
au BufEnter REPL execute 'normal G' | startinsert!
au BufLeave REPL stopinsert

NeoBundle "vim-scripts/VimClojure"
let vimclojure#ParenRainbow=1
let maplocalleader=','
"let vimclojure#WantNailgun=1  " Requires: vimclojure-nailgun-client (ng) & lein-tarsier (in plugins of ~/.lein/profiles.clj)

" Semantic web-related plugins

NeoBundle "vim-scripts/n3.vim"

