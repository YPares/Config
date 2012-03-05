hbx()
{
    (($#==0)) && { \ls "$HASKELL_SANDBOXES"; return; }
    sandbox="$1"
    sandbox_path="$HASKELL_SANDBOXES/$sandbox"
    pkgconf="$sandbox_path/package.conf"

    if [ ! -e "$pkgconf" ]; then
        \ghc-pkg init "$pkgconf"
        echo "Sandbox '$sandbox' created at $sandbox_path."
        (($#==1)) && return;
    elif (($#==1)); then
        \ghc-pkg --package-conf="$pkgconf" list
        return
    fi

    command="$2"
    shift
    shift

    case "$command" in
        setlocal)
            > "$sandbox_path/install_here"
            echo "Sandbox '$sandbox' set for installation in place. (Binaries and doc won't be in put in your .cabal)"
            ;;
        delete)
            \rm -r "$sandbox_path" > /dev/null
            echo "Sandbox '$sandbox' deleted."
            ;;
        rename)
            name="$1"
            [ -z "$name" ] && {
                echo "You must provide a new sandbox name." 1>&2
                return 1;
            }
            \mv "$sandbox_path" "$HASKELL_SANDBOXES/$name" &&
            echo "Sandbox '$sandbox' renamed to '$name'."
            ;;
        copy)
            name=${1-${sandbox}.copy}
            \cp -R "$sandbox_path" "$HASKELL_SANDBOXES/$name" # > /dev/null &&
            echo "Sandbox '$sandbox' copied into '$name'."
            ;;
        cd)
            cd "$sandbox_path"
            ;;
        ghc)
            \ghc -no-user-package-conf -package-conf "$pkgconf" "$@"
            ;;
        ghci)
            \ghci -no-user-package-conf -package-conf "$pkgconf" "$@"
            ;;
        pkg)
            \ghc-pkg --package-conf="$pkgconf" "$@"
            ;;
        configure | install)
            prefix=""
            [ -e "$sandbox_path/install_here" ] && prefix="--prefix=$sandbox_path"
            \cabal "$command" --package-db="$pkgconf" $prefix "$@"
            ;;
        inbox)
            tempdir="/tmp/haskell-box-$$"
            [ -d "$tempdir" ] &&
                rm -rf $tempdir/* > /dev/null ||
                mkdir $tempdir
            for c in ghc ghci; do
                echo "#!/bin/sh
$(which $c) -no-user-package-conf -package-conf \"$pkgconf\" \"\$@\"" > "$tempdir/$c"
                chmod +x "$tempdir/$c"
            done
            ghcmodpath="$(which ghc-mod)"
            if [ -n "$ghcmodpath" ]; then
                echo "#!/bin/sh
$ghcmodpath --ghcOpt=-no-user-package-conf '--ghcOpt=-package-conf $pkgconf' \"\$@\"" > "$tempdir/ghc-mod"
                chmod +x "$tempdir/ghc-mod"
            fi
            ( PATH="$tempdir:$PATH" "$@"; )
            rm -rf $tempdir > /dev/null
            ;;
        aliases)
            alias ghc="hbx \"$sandbox\" ghc"
            alias ghci="hbx \"$sandbox\" ghci"
            alias pkg="hbx \"$sandbox\" pkg"
            alias configure="hbx \"$sandbox\" configure"
            alias install="hbx \"$sandbox\" install"
            alias build="cabal build"
            alias register="cabal register --inplace"
            [ -n "$EDITOR" ] &&
                alias "$EDITOR"="hbx \"$sandbox\" inbox $EDITOR"
            alias inbox="hbx \"$sandbox\" inbox"
            ;;
        *) echo "Error: invalid haskell-box command: '$command'" 1>&2
    esac
}
_hbx()  # Bash completion function
{
    if ((COMP_CWORD==1)); then
        local cur="${COMP_WORDS[1]}"
        COMPREPLY=( $(compgen -W "$(\ls "$HASKELL_SANDBOXES")" -- "$cur") )
    else
         ((COMP_CWORD-=1))
#         unset COMP_WORDS[0]
#         unset COMP_WORDS[1]  # unset DOES NOT remove the cell! It merely blanks it
#         COMP_WORDS=( "cabal" "${COMP_WORDS[@]}" )  # ... and this does not take blank cells ...
#         _cabal
    fi
}
complete -o default -F _hbx hbx

