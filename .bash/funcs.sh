spk()
{
    festival -b '(SayText "'"$*"'")'
}

w2u()
{
    (( $# == 0 )) && 
    { echo "1 param!"; return 1; }
    tmp="/tmp/$$"
    iconv -f cp1252 -t utf8 "$1" > "$tmp"
    \mv "$tmp" "$1"
}

gtr()
{
    [[ $(pwd) == "/" || -d "_darcs" ]] || { cd .. && gtr; }
}

transformStdinToPattern()
{
    sed 's/ /*/g
         s/a/[aàä]/g
         s/e/[eéèë]/g
         s/i/[iï]/g
         s/o/[oö]/g
         s/u/[uü]/g
         s/y/[yÿ]/g'
}
                                           
GO_PATH=".:/data:$HOME"

__printMatches() # each line in stdin is a dir from GO_PATH
{
    while read dir; do
        if [[ -n "$dir" ]]; then
            find "$dir" -iwholename "*$(transformStdinToPattern <<< "$*")"
        fi
    done
}

go()
{
    read found < <(sed 's/:/\
/g' <<< "$GO_PATH" | __printMatches "$@" 2> /dev/null)
    if [[ "$found" == "\
" ]]; then
        echo "No directory found ('$@')."
    elif [[ -d "$found" ]]; then
        cd "$found"
    else
        cd "$(dirname "$found")"
    fi
}

all()
{
    pattern="$1"
    shift
    cmd="$@"
    if [[ -n "$cmd" ]]; then
        eval $cmd $(find . -iname "*$pattern")
    else
        find . -iname "*$pattern"
    fi
}

MY_SSH="limestrael@172.20.2.64"

mtaudio()
{
    [[ -d "/data/audio" ]] &&
        { echo "Audio already mounted" && return; }
    mkdir -p /data/audio
    sshfs -o ro "$MY_SSH:/data/audio" /data/audio
    symlib
}

umtaudio()
{
    [[ -d "/data/audio" ]] ||
        { echo "Audio not mounted" && return; }
    rm -rf "$HOME/symlib" > /dev/null
    fusermount -u /data/audio
    rmdir /data/audio
}

