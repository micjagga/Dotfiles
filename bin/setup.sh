#!/usr/bin/env bash
source ./configurations/bot/echos.sh
# Copy binaries
ln -fs ./bin $HOME

declare -a BINARIES=(
    'batcharge.py'
    'crlf'
    'dups'
    'fasd'
    'git-delete-merged-branches'
    'nyan'
    'passive'
    'proofread'
    'ssh-key'
    'weasel'
)

for i in ${BINARIES[@]}; do
  action "Changing access permissions for binary script :: ${i##*/}"
  chmod +rwx $HOME/bin/${i##*/}
done
ok
unset BINARIES
