function GHC_DispResult(cmd, res)
     pclose
     rightbelow 6 new GHCi\ result
     setlocal previewwindow
     setlocal buftype=nofile
     setlocal noswapfile
     setlocal syntax=haskell
     put! ='> ' . a:cmd
     put =a:res
endfunction

