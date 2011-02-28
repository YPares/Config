__gitdir()
{
    if [ -z "${1-}" ]
    then
        if [ -n "${__git_dir-}" ]
        then
            echo "$__git_dir"
        else
            if [ -d .git ]
            then
                echo .git
            else
                git rev-parse --git-dir 2>/dev/null
            fi
        fi
    else
        if [ -d "$1/.git" ]
        then
            echo "$1/.git"
        else
            echo "$1"
        fi
    fi
}

__git_ps1()
{
    local g="$(__gitdir)"
    if [ -n "$g" ]
    then
        local r
        local b
        if [ -f "$g/rebase-merge/interactive" ]
        then
            r="|REBASE-i"
            b="$(cat "$g/rebase-merge/head-name")"
        else
            if [ -d "$g/rebase-merge" ]
            then
                r="|REBASE-m"
                b="$(cat "$g/rebase-merge/head-name")"
            else
                if [ -d "$g/rebase-apply" ]
                then
                    if [ -f "$g/rebase-apply/rebasing" ]
                    then
                        r="|REBASE"
                    else
                        if [ -f "$g/rebase-apply/applying" ]
                        then
                            r="|AM"
                        else
                            r="|AM/REBASE"
                        fi
                    fi
                else
                    if [ -f "$g/MERGE_HEAD" ]
                    then
                        r="|MERGING"
                    else
                        if [ -f "$g/BISECT_LOG" ]
                        then
                            r="|BISECTING"
                        fi
                    fi
                fi
                b="$(git symbolic-ref HEAD 2>/dev/null)" || {
                    b="$(
                        case "${GIT_PS1_DESCRIBE_STYLE-}" in
                        (contains)
                            git describe --contains HEAD ;;
                        (branch)
                            git describe --contains --all HEAD ;;
                        (describe)
                            git describe HEAD ;;
                        (* | default)
                            git describe --exact-match HEAD ;;
                        esac 2>/dev/null)" || b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..."  || b="unknown";
                    b="($b)"
                }
            fi
        fi
        local w
        local i
        local s
        local u
        local c
        if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]
        then
            if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]
            then
                c="BARE:"
            else
                b="GIT_DIR!"
            fi
        else
            if [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]
            then
                if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]
                then
                    if [ "$(git config --bool bash.showDirtyState)" != "false" ]
                    then
                        git diff --no-ext-diff --ignore-submodules --quiet --exit-code || w="*"
                        if git rev-parse --quiet --verify HEAD >/dev/null
                        then
                            git diff-index --cached --quiet --ignore-submodules HEAD -- || i="+"
                        else
                            i="#"
                        fi
                    fi
                fi
                if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]
                then
                    git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
                fi
                if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]
                then
                   if [ -n "$(git ls-files --others --exclude-standard)" ]
                    then
                        u="%"
                    fi
                fi
            fi
        fi
        if [ -n "${1-}" ]
        then
            printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
        else
            printf " %s" "$c${b##refs/heads/}$w$i$s$u$r"
        fi
    fi
}

case $- in
    *i*)
        PS1="\[\033]0;$MSYSTEM\w\007[\033[32m\]\u@\h \[\033[1;34m\W\033[0m\033[33m\$(__git_ps1)\033[0m\]]
$ "
        ;;
esac

