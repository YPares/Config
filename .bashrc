# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

for f in ~/.bash/*.sh; do
  . "$f"
done

last_dirs_in_path() {
    pwd | awk -F\/ '{sub("'$HOME'","~",$0); out = ""; if(NF-2 > 0){ out = $(NF-2) "/"; } ; if (NF-1 > 0) { out = out $(NF-1) "/" } ; print out $(NF)}'
}
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]@\h\[\033[00m\] \[\033[01;34m\]$(last_dirs_in_path)\[\033[00m\]\$ '


PATH=$PATH:$HOME/.rvm/bin:$HOME/.gem/ruby/2.1.0/bin # Add RVM to PATH for scripting

function __vte_prompt_command() { echo -n ""; }


export PATH=/home/yves/.local/bin:$PATH
