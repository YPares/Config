setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc

set shiftwidth=2
set tabstop=2

map <silent> [[ :call haskell#goto_beginning_decl()<Return>
map <silent> ]] :call haskell#goto_beginning_next_decl()<Return>

map <buffer> _tt :GhcModType<Return>
map <buffer> <silent> _tr :GhcModTypeClear<Return>
map <buffer> _ti :w<Return>:GhcModTypeInsert<Return>
map <buffer> _i :GhcModInfoPreview!<Return>
map <buffer> _c :w<Return>:GhcModCheckAsync<Return>
map <buffer> _f :cfirst<Return>
map <buffer> _cf :w<Return>:GhcModCheck<Return>:cfirst<Return>
map <buffer> _n :cnext<Return>
map <buffer> _p :cprevious<Return>
"map <buffer> _tt :HdevtoolsType<Return>
"map <buffer> <silent> _tc :HdevtoolsClear<Return>
"map <buffer> _ti :HdevtoolsInfo<Return>


let b:ghc='ghc -v0 -O0 -outputdir _build.d/vim'

" Build the tags file
" To be used with :make and quickfix (:copen, :cc, etc)
map <buffer> <silent> _ct :cexpr system('ghc -v0 -w ' . $GHC_STATICOPTS . ' -e ":ctags!" ' . expand("%"))<Return>

command! -buffer HC cexpr system(b:ghc . ' ' . $GHC_STATICOPTS . ' -no-link ' . expand("%"))

command! -buffer -complete=tag -nargs=1 HI call GHC_DispResult(<f-args>, system(b:ghc . ' ' . $GHC_STATICOPTS . ' ' . expand("%") . ' -e "' . escape(<f-args>,'"') . '"'))

