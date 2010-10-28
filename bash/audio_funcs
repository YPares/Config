#!/bin/bash


AUDIO_DIRS=/data/audio_sorted/*
MEDIALIB_DIR=/data/_audio
COVERS_NAME=cover.jpg
TMP_PLAYLIST="/tmp/bashmuze-$USER.m3u"

OGGENC_OPTS=-q7

COVERS=resize  # Can ben 'keep', 'resize' or 'remove'

COVERS_SIZE=240x320


alias aq="aqualung -N0"

callPlayer()
{
  aq "$1"
  sleep 0.2
  aq --play
}


audiolib()
{
  [[ -d $MEDIALIB_DIR ]] && rm -rf $MEDIALIB_DIR &>/dev/null
  mkdir $MEDIALIB_DIR
  cp -RL $([[ -z "$1" ]] && echo -l || echo -s) $AUDIO_DIRS/* $MEDIALIB_DIR &>/dev/null
}


getwp()
{
  gconftool --get /desktop/gnome/background/picture_filename
}

setwp()
{
  wp="$(realpath "$1")"
  { read screenWidth && read screenHeight; } < <(xrandr | grep '*' | sed 's/\s*\([0-9]\+\)x\([0-9]\+\).*/\1\n\2/')
    { read wpWidth && read wpHeight; } < <(identify -format "%w\n%h" "$wp")
      mode=centered
      (( wpWidth > screenWidth || wpHeight > screenHeight )) && mode=scaled
      gconftool --type string --set /desktop/gnome/background/picture_options "$mode"
      gconftool --type string --set /desktop/gnome/background/picture_filename "$wp"
    }


    ### FIND functions ###

    mfind()
    {
      find $MEDIALIB_DIR "$@" \( -type f -o -type l \) 2>/dev/null
    }

    mfindsort()
    {
      mfind "$@" | sort
    }


    _processPattern()
    {
      local spaceReplacement="*"
      [[ "$2" == True ]] && spaceReplacement='[ _-,;:.(){}]'
      echo "$1" |
      sed -e "s/ /$spaceReplacement/g" -e "s/a/[aàä]/g" \
        -e "s/e/[eéèë]/g" -e "s/i/[iï]/g" \
        -e "s/o/[oöô]/g"   -e "s/u/[uü]/g" \
        -e "s/y/[yÿ]/g"   -e "s/c/[cç]/g"
    }

    findOne()
    {
      parseFMOpts()
      {
        local opts=$1
        local i=0
        local rest

        while rest=${opts:$i}
          [[ -n "$rest" ]]
        do
          getNumber(){ local num=$(expr match "${rest:1}" '\([0-9]\+\).*')
            ((i += ${#num}))
            echo ${num:-1}; }

            case "${rest:0:1}" in
              r) RANDOM_CHOICE=True ;;
            f) FILES_NUMBER=$(getNumber) ;;
          n) SEARCH_TYPE=-iname ;;
        e) EXACT=True ;;
      esac
      ((i++))
    done
  }

  echo "$*" | tr ',' $'\n' |     # Goddam ugly workaround
  while read arg; do
    local RANDOM_CHOICE=""
    local FILES_NUMBER=0
    local SEARCH_TYPE=-iwholename
    local EXACT=""

    if [[ "$arg" == *:* ]]; then  # We have some options
      local opts=${arg##*:}
      if [[ -z "$opts" ]]; then  # A trailing ':' results in 'one file' mode,
        # searching on the files names (: == :nf1)
        FILES_NUMBER=1
        SEARCH_TYPE=-iname
      else
        parseFMOpts "$opts"
      fi
    fi
    local pattern="$(_processPattern "${arg%:*}" $EXACT)"

    coversPat=""
    [[ "$COVERS" == remove ]] && coversPat="! -iname $COVERS_NAME"
    mfindsort "$SEARCH_TYPE" "*$pattern*" $coversPat
    { [[ $RANDOM_CHOICE == True ]] && shuf || cat; } |
      { [[ $FILES_NUMBER > 0 ]] && head -n $FILES_NUMBER || cat; }
    done
  }

  fm()
  {
    echo "$*" | tr ',' $'\n' | while read arg; do findOne $arg; done
  }

  lm()
  {
    local pattern="$(_processPattern "$*" False)"
    ( cd "$MEDIALIB_DIR"
    find . -type d -iname "$pattern" |
    while read dir; do
      sedProcess="s/_/ /g
      s/ - /: /g
      s/-\(.*\)-/(\1)/g"
      echo "$dir" | sed -e "$sedProcess
      s#^\./##
      s#/# > #g"
      ( cd "$dir"
      ls -1 | sed -ne "/$COVERS_NAME/ !{
      $sedProcess
      s/\.[^\.]\+$//
      s/^/  /
      p
    }" )
  done )
}

fmh()
{
  MEDIALIB_DIR="$(realpath .)" fm "$*"
}

pl()
{
  fm "$*" > "$TMP_PLAYLIST"
  callPlayer "$TMP_PLAYLIST"
}

plh()
{
  MEDIALIB_DIR="$(realpath .)" pl "$*"
}

epl()
{
  fm "$*" > "$TMP_PLAYLIST"
  ${EDITOR:-nano} "$TMP_PLAYLIST"
  callPlayer "$TMP_PLAYLIST"
}

eplh()
{
  MEDIALIB_DIR="$(realpath .)" epl "$*"
}


syncto()
{
  (( $# == 0 )) && { echo "*** Usage: syncto dest [formatForFlacFiles]"
  echo "*** Reads from stdin files to be sync'ed"
  return 1; }
  dest="$1"
  flacConversion="${2:-flac}"

  while read file; do
    echo "$file"
    echo "$(realpath -s "$dest/${file#$MEDIALIB_DIR}")"
  done |
  while read srcfile && read dstfile; do
    dstdir="$(dirname "$dstfile")"
    [[ -d "$dstdir" ]] ||
      mkdir -p "$dstdir"
    [[ -f "$dstfile" || -f "${dstfile%.*}.ogg" || -f "${dstfile%.*}.mp3" ]] || {
    function rawCopy()
    {
      cp -Lv "$srcfile" "$dstfile"
    }

    case "$(file --mime-type -bL "$srcfile")" in
      audio/x-flac) 
        case $flacConversion in
          ogg)
            oggenc $OGGENC_OPTS "$srcfile" -o "${dstfile%.*}.ogg" ;;
          mp3)
            flac2mp3 "$srcfile" "${dstfile%.*}.mp3" ;;
          *)
            rawCopy ;;
        esac ;;
      image/jpeg)
        if [[ "$COVERS" == resize ]]; then
          echo "Resizing '$srcfile' to '$dstfile' ($COVERS_SIZE)"
          convert "$srcfile" -resize ${COVERS_SIZE}\> "$dstfile"
        else
          rawCopy
        fi ;;
      *)  
        rawCopy ;;
    esac
  }
done
}

editAndSyncto()
{
  (( $# < 3 )) && { echo "*** Usage: editAndSyncto dest formatForFlacFiles <fm-args>"
  return 1; }

  local tmpFile="/tmp/syncto$$"
  fm "${*:3}" > "$tmpFile"
  ${EDITOR:-nano} "$tmpFile"
  syncto "$1" "$2" < <(cat "$tmpFile"; : $(rm -f "$tmpFile"))
}

