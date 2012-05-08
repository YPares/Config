setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc

setlocal shiftwidth=2
setlocal tabstop=2

map <buffer> <silent> _tt :GhcModType<Return>
map <buffer> _tc :GhcModTypeClear<Return>

let b:ghc='ghc -v0 -O0 -outputdir _vim_make.d'

" Build the tags file
" To be used with :make and quickfix (:copen, :cc, etc)
map <buffer> <silent> _ct :cexpr system('ghc -v0 ' . $GHC_STATICOPTS . ' -e ":ctags!" ' . expand("%"))<Return>

command! -buffer HC cexpr system(b:ghc . ' ' . $GHC_STATICOPTS . ' -no-link ' . expand("%"))

command! -buffer -complete=tag -nargs=1 HI call GHC_DispResult(<f-args>, system(b:ghc . ' ' . $GHC_STATICOPTS . ' ' . expand("%") . ' -e "' . escape(<f-args>,'"') . '"'))

