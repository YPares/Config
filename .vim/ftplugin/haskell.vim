setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc

setlocal shiftwidth=2
setlocal tabstop=2

map <buffer> <silent> _tt :GhcModType<Return>
map <buffer> _tc :GhcModTypeClear<Return>

" Build the tags file and pass errors to quickfix
map <buffer> <silent> _ct :cexpr system('ghc -v0 -e ":ctags" ' . expand("%"))<Return>

let b:ghc='ghc -v0 -O0 -outputdir _vim_make.d'

" To be used with :make and quickfix (:copen, :cc, etc)
execute 'setlocal makeprg=' . escape(b:ghc, ' ') . '\ -no-link\ %'

command! -complete=tag -nargs=1 HI call GHC_DispResult(<f-args>, system(b:ghc . ' ' . expand("%") . ' -e "' . escape(<f-args>,'"') . '"'))
function! GHC_DispResult(cmd, res)
     pclose
     rightbelow 6 new GHCi\ result
     setlocal previewwindow
     setlocal buftype=nofile
     setlocal noswapfile
     setlocal syntax=haskell
     put! ='> ' . a:cmd
     put =a:res
endfunction

