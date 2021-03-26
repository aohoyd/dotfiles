#!/usr/bin/env zsh
set -euo pipefail

function attach_tmux() {
    local sName=local
    /usr/local/bin/tmux attach -t $sName || {
        /usr/local/bin/tmux new-session -d -c ~ -s $sName "nnn"
        /usr/local/bin/tmux new-window -d -c ~ -n "shell"
        /usr/local/bin/tmux attach -t $sName
    }

}

attach_tmux
