function GHC_DispResult(cmd, res)
     pclose
     rightbelow 8 new GHCi\ result
     setlocal previewwindow
     setlocal buftype=nofile
     setlocal noswapfile
     setlocal syntax=haskell
     put! ='> ' . a:cmd
     put =a:res
     wincmd p
endfunction

command CABAL cexpr system("cabal build -v0")

function haskell#goto_beginning_decl_with_opts(search_opts)
  call search('^\S', 'b' . a:search_opts)
  let curword = expand('<cword>')
  if index(['data', 'type', 'newtype', 'class', 'instance', 'module', 'import', 'where'], curword) == -1
    call search('^' . curword, 'bW')
    return curword
  endif
  return ''
endfunction

function haskell#goto_beginning_decl()
  call haskell#goto_beginning_decl_with_opts('')
endfunction

function haskell#goto_beginning_next_decl()
  let name_declared = haskell#goto_beginning_decl_with_opts('c')
  " If we already are on the first line of a decl, we stay where we are
  call search('^\S')
  if name_declared == expand('<cword>')
    call search('^\S')
  endif
endfunction

