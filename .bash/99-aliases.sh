alias proxies="export http_proxy='http://172.20.0.6:3128' && export ftp_proxy='http://172.20.0.6:3128'"

alias sshinsa="ssh -fNL 2012:asi-mahr211-01.insa-rouen.fr:22 ypares@ssh.insa-rouen.fr"
alias sshnet="ssh -fND 1024 ypares@ssh.insa-rouen.fr"

alias grep="grep -i"

alias m="mplayer"

alias syncaudio="rsync -av $AUDIO_TOP_DIR/ /media/scorpio/Audio"

alias ls='ls -B --color=auto --group-directories-first'
alias l="ls"
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias t='tree'
alias mv="mv -v"
alias rm="rm -v"
alias cp="cp -v"
alias o="xdg-open"

alias u='[[ "$PWD" != / ]] && pushd ..'
alias d="popd"

alias ff="find . -iname"

alias ed="ed -p'> '"

alias ipython="ipython -nobanner -noconfirm_exit"
alias py="ipython"
alias mkpy="echo '#encoding=UTF-8



' >"

alias mkpyexe="echo '#!/usr/bin/env python 
#encoding=UTF-8



' >"


alias hc="ghc -outputdir _build.d -fwarn-incomplete-patterns"
alias hi="ghci -outputdir _build.d -fwarn-incomplete-patterns"

alias dx="darcs"

alias sc="mkdir -p _classes; fsc -d _classes"
alias scala="scala -cp _classes"

setupSaves()
{
    for i in /Data/Software/Saves/home/*; do f="$HOME/.`basename "$i"`"; [ -e "$f" ] || ln -s "$i" "$f"; done

    for i in /Data/Software/Saves/local-share/*; do f="$HOME/.local/share/`basename "$i"`"; [ -e "$f" ] || ln -s "$i" "$f"; done
}

