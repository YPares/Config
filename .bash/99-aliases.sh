alias proxies="export http_proxy='http://172.20.0.6:3128' && export ftp_proxy='http://172.20.0.6:3128'"

alias sshinsa="ssh -fNL 2012:asi-mahr211-01.insa-rouen.fr:22 ypares@ssh.insa-rouen.fr"
alias sshnet="ssh -fND 1024 ypares@ssh.insa-rouen.fr"

alias grep="grep -i"

alias g="git"
alias gg="git g -n13"

alias m="mplayer"

alias syncaudio="rsync -rtuv --size-only /Data/Audio/Sorted/ /run/media/ywen/scorpio/Audio/Sorted/"
alias syncaudioback="rsync -rtuv --size-only /run/media/ywen/scorpio/Audio/Sorted/ /Data/Audio/Sorted/"

alias ls='ls -B --color=auto --group-directories-first'
alias l="ls"
alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lAh'
alias t='tree'
alias mv="mv -v"
alias rm="rm -v"
alias cp="cp -v"
alias o="xdg-open"

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias u='[[ "$PWD" != / ]] && pushd ..'
alias d="popd"

alias ff="find . -iname"

alias sag="sudo apt-get"
alias sagi="sudo apt-get install"
alias sagu="sudo apt-get update"
alias saguu="sudo sh -c 'apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y'"

alias ed="ed -p'> '"

alias py="ipython3"
alias mkpy="echo '#encoding=UTF-8



' >"

alias mkpyexe="echo '#!/usr/bin/env python 
#encoding=UTF-8



' >"


alias shi="stack ghci --no-load --no-build"
alias hc="ghc -outputdir _build.d/default -fwarn-incomplete-patterns"
alias hi="ghci -outputdir _build.d/default -fwarn-incomplete-patterns"
alias hcp="ghc -outputdir _build.d/prof -prof -fprof-auto-top -fprof-cafs -O2"

alias dx="darcs"

alias sc="mkdir -p _classes; fsc -d _classes"
alias scala="scala -cp _classes"

if [ -n "`which clojure`" ]; then
    alias clj="clojure"
else alias clj="lein repl"
fi

if [ -n "`which nix`" ]; then
    alias nixsr="nix-shell --indirect --add-root _nix-gc-roots/root"
fi

alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'

