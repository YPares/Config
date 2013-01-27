setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc

set shiftwidth=2
set tabstop=2

map <buffer> _tt :HdevtoolsType<Return>
map <buffer> <silent> _tc :HdevtoolsClear<Return>
map <buffer> _ti :HdevtoolsInfo<Return>

let b:ghc='ghc -v0 -O0 -outputdir _build.d/vim'

" Build the tags file
" To be used with :make and quickfix (:copen, :cc, etc)
map <buffer> <silent> _ct :cexpr system('ghc -v0 -w ' . $GHC_STATICOPTS . ' -e ":ctags!" ' . expand("%"))<Return>

command! -buffer HC cexpr system(b:ghc . ' ' . $GHC_STATICOPTS . ' -no-link ' . expand("%"))

command! -buffer -complete=tag -nargs=1 HI call GHC_DispResult(<f-args>, system(b:ghc . ' ' . $GHC_STATICOPTS . ' ' . expand("%") . ' -e "' . escape(<f-args>,'"') . '"'))

