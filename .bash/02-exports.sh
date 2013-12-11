if [ "x$EMACS" = "xt" ]; then
    export EDITOR=emacsclient
else
    export EDITOR=vim
fi
#export PYTHONSTARTUP=$HOME/.pythonrc.py

export PATH="$PATH:$HOME/.bin:$HOME/.cabal/bin:$HOME/.cabal-sandboxes/exes/bin"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export LIBRARY_PATH="$LD_LIBRARY_PATH"

[ -z "$TMUX" ] && export TERM="xterm-256color"

export HASKELL_SANDBOXES="/Data/Devel/Sandboxes/Haskell"

export SAVES_DIR=$HOME/Dropbox/Saves

export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
#export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
#export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

export DOC_SOURCES_DIRS=/Data/Docs/Sources/*
export DOC_SYMLIB_DIR=/Data/Docs/_Library
