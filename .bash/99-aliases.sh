alias proxies="export http_proxy='http://172.20.0.6:3128' && export ftp_proxy='http://172.20.0.6:3128'"

alias sshinsa="ssh -fNL 2012:asi-mahr211-01.insa-rouen.fr:22 ypares@ssh.insa-rouen.fr"
alias sshnet="ssh -fND 1024 ypares@ssh.insa-rouen.fr"

alias grep="grep -i"

alias m="mplayer"

alias syncaudio="rsync -rtuv $AUDIO_TOP_DIR/ /media/scorpio/Audio/Sorted"
alias syncaudioback="rsync -rtuv /media/scorpio/Audio/Sorted/ $AUDIO_TOP_DIR"

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

alias u='[[ "$PWD" != / ]] && pushd ..'
alias d="popd"

alias ff="find . -iname"

alias sagi="sudo apt-get install"

alias ed="ed -p'> '"

alias ipython="ipython -nobanner -noconfirm_exit"
alias py="ipython"
alias mkpy="echo '#encoding=UTF-8



' >"

alias mkpyexe="echo '#!/usr/bin/env python 
#encoding=UTF-8



' >"


alias hc="ghc -outputdir _build.d/default -fwarn-incomplete-patterns"
alias hi="ghci -outputdir _build.d/default -fwarn-incomplete-patterns"
alias hcp="ghc -outputdir _build.d/prof -prof -fprof-auto -fprof-cafs -O2"

alias dx="darcs"

alias sc="mkdir -p _classes; fsc -d _classes"
alias scala="scala -cp _classes"

