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
    d=${1-.}

    if [[ -d "$d/.git" || -d "$d/_darcs" ||
          ( -d "$d/.svn" && ! -d "$d/../.svn" ) ||
          -e "$d/.fake-root" ||
          "$(readlink -f "$d")" == "/" ]]; then
        cd "$d"
        pwd
    else
        gtr "$d/.."
    fi
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

map()
{
    [[ -z "$1" ]] &&
      { echo "Usage: map <command> [<file1> <file2> ...]"
        return 1; }
    cmd="$1"
    shift
    [[ -z "$@" ]] && { set *; }
    rec() { [[ -n "$1" ]] && eval "$cmd" "\"$1\"" && shift && rec "$@"; }
    rec "$@"
}

vimp()
{
    path="`readlink -f .`"
    for arg in "$@"; do
        path="$path,`readlink -f "$arg"`"
    done
    vim -c "set path+="$path""
}

githubclone()
{
    repo="$1"
    shift
    git clone "https://github.com/$repo.git" "$@"
}

setupSaves()
{
    for i in /Data/Software/Saves/home/*; do f="$HOME/.`basename "$i"`"; [ -e "$f" ] || ln -s "$i" "$f"; done

    for i in /Data/Software/Saves/local-share/*; do f="$HOME/.local/share/`basename "$i"`"; [ -e "$f" ] || ln -s "$i" "$f"; done
}

