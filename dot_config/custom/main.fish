#!/usr/bin/env fish

source (brew --prefix asdf)/asdf.fish

function atttmux
    set -l sName local
    set -l tmux /usr/local/bin/tmux
    $tmux attach -t $sName || begin
        $tmux new-session -d -c ~ -s $sName "nnn"
        $tmux new-window -d -c ~ -n "shell"
        $tmux attach -t $sName
    end
end

set TERM xterm-256color
set EDITOR /usr/local/bin/emacs

set LC_ALL en_US.UTF-8

set PATH $PATH ~/go/bin

set NNN_PLUG 'f:finder;o:fzopen;c:fzcd'
