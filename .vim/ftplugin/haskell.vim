setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc

setlocal shiftwidth=2
setlocal tabstop=2

map <buffer> <silent> _tt :GhcModType<Return>
map <buffer> _tc :GhcModTypeClear<Return>

map _ct :call GHC_CreateTagfile()<cr>
function! GHC_CreateTagfile()
  redraw
  echo "creating tags file" 
  let output = system('ghc -e ":ctags" ' . expand("%"))
  echo output
endfunction

