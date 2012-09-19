" Requires clojure config to be added in $HOME/.ctags
map <buffer> <silent> _ct :cexpr system('ctags -R .')<Return>

