export EDITOR=vim
#export PYTHONSTARTUP=$HOME/.pythonrc.py

export PATH="$PATH:$HOME/.bin:$HOME/.cabal/bin:$HOME/.cabal-sandboxes/exes/bin"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export LIBRARY_PATH="$LD_LIBRARY_PATH"

[ -z "$TMUX" ] && export TERM="xterm-256color"

export HASKELL_SANDBOXES="/Data/Devel/Sandboxes/Haskell"

