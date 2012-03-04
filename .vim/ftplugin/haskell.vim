setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc

setlocal shiftwidth=2
setlocal tabstop=2

map <buffer> <silent> _tt :GhcModType<Return>
map <buffer> _tc :GhcModTypeClear<Return>

map <silent> _ct :call GHC_CreateTagfile()<cr>
function! GHC_CreateTagfile()
  let output = system('ghc -e ":ctags" ' . expand("%"))
  echo output
  echo "tags file created" 
endfunction

let g:ghc_check='ghc -v0 -O0 -no-link -outputdir _vim_make.d'

" To be used with :make and quickfix (:copen, :cc, etc)
execute 'setlocal makeprg=' . escape(g:ghc_check, ' ') . '\ %'

command! -nargs=1 HI echo system(g:ghc_check . ' ' . expand("%") . ' -e "' . escape(<f-args>,'"') . '"')

