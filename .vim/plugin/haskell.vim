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

