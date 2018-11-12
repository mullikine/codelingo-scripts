#!/bin/bash
export TTY

# run this script from the tenet directory

td_tenet="$(mktemp -t -d td_tenetXXXXXX || echo /dev/null)"
trap "rmdir \"$td_tenet\" 2>/dev/null" 0

drp="$(realpath ".")"

from_dn="$drp"
{
    mkdir -p "$td_tenet"
    echo "Constructing new git repo in temp folder..."

    /usr/bin/rsync  -a -rtlhx -pug -s  --inplace --append   --exclude .cache  --exclude .git/ --exclude .gitignore --exclude TODO  --exclude '*~' --exclude '.#*' "$from_dn/" "$td_tenet"

    echo tags > "${td_tenet}/.gitignore"
} 1>&2
printf -- "%s\n" "$td_tenet"

cd "$td_tenet"
git init
git add -A .
git commit -m "initial commit"
bash
