#!/usr/bin/env bash

APPNAME="cheat"
VERSION="0.0.1"
CHEAT_BASE_PATH=${CHEAT_BASE_PATH:-$HOME/src/github.com/onigomex/cheat/sheet}

usage() {
echo "Usage: $APPNAME [--help|--version] [option] [args]
Version: $VERSION

Option:
    -f [filter]  List cheat files
    -c           cd $CHEAT_BASE_PATH

Customize:
    export CHEAT_BASE_PATH=\"$CHEAT_BASE_PATH\"

Examples:
    $APPNAME : List cheats
    $APPNAME xxx : List cheats filtered by the string xxx
    $APPNAME -f : List all cheat files
    $APPNAME -f xxx : List cheat files filtered by the string xxx
    $APPNAME -c : cd $CHEAT_BASE_PATH

Dependencies:
    - fzf: https://github.com/junegunn/fzf
"
exit 0
}

version() {
    echo "$APPNAME $VERSION"
    exit 0
}

item() {
    if [[ -z $1 ]]; then
        local res=$(find $CHEAT_BASE_PATH -type f \
            | xargs grep -n -e '^## .*' \
            | sed -e "s@$CHEAT_BASE_PATH/@@" -e 's/.md//' -e 's/:## /: /' \
            | fzf \
            --multi --cycle \
            --bind=ctrl-u:half-page-up,ctrl-d:half-page-down \
            )
    else
        local res=$(find $CHEAT_BASE_PATH -type f \
            | xargs grep -n -e '^## .*' \
            | sed -e "s@$CHEAT_BASE_PATH/@@" -e 's/.md//' -e 's/:## /: /' \
            | fzf -f "$1" \
            | fzf \
            --multi --cycle \
            --bind=ctrl-u:half-page-up,ctrl-d:half-page-down \
            )
    fi

    [[ -z $res ]] && return
    local file_name=$(echo $res | cut -d: -f1)
    local line_num=$(echo $res | cut -d: -f2)
    vim -c $line_num $CHEAT_BASE_PATH/$file_name.md
}

file() {
    if [[ -z $1 ]]; then
        local res=$(find $CHEAT_BASE_PATH -type f \
            | sed -e "s@$CHEAT_BASE_PATH/@@" -e 's/.md//' \
            | fzf \
            --preview "less -R $CHEAT_BASE_PATH/{}.md" \
            --multi --cycle \
            --bind=ctrl-u:half-page-up,ctrl-d:half-page-down \
            )
    else
        local res=$(find $CHEAT_BASE_PATH -type f \
            | sed -e "s@$CHEAT_BASE_PATH/@@" -e 's/.md//' \
            | fzf -f "$1" \
            | fzf \
            --preview "less -R $CHEAT_BASE_PATH/{}.md" \
            --multi --cycle \
            --bind=ctrl-u:half-page-up,ctrl-d:half-page-down \
            )
    fi

    [[ -z $res ]] && return
    vim "$CHEAT_BASE_PATH/$res.md"
}

changedir() {
    cd "$CHEAT_BASE_PATH"
    exec $SHELL
}

main() {
    [[ "$1" == "--help" ]] && usage
    [[ "$1" == "--version" ]] && version

    local option="$1"
    case $option in
        -f)    shift && file "$@" && return ;;
        -c)    shift && changedir && return ;;
        *)     item "$@" && return ;;
    esac
}

main "$@"

