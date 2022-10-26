#!/usr/bin/env fish

source /run/current-system/sw/share/fish/vendor_completions.d/asdf.fish
source (dirname (status --current-filename))/kube-vars.fish
source (dirname (status --current-filename))/kube-alias.fish

function atttmux
    set -l sName local
    set -l tmux /usr/local/bin/tmux
    $tmux attach -t $sName || begin
        $tmux new-session -d -c ~ -s $sName "nnn"
        $tmux new-window -d -c ~ -n "shell"
        $tmux attach -t $sName
    end
end

set -x TERM xterm-256color
set -x EDITOR /usr/local/bin/emacsclient -t
set -x VISUAL /usr/local/bin/emacsclient -c
set -x DOCKER_HOST 'unix:///Users/avlllo/.local/share/containers/podman/machine/podman-machine-default/podman.sock'

set -x GOPRIVATE gitlab.ptsecurity.com

set -x LC_ALL en_US.UTF-8

set -x PATH $PATH ~/go/bin ~/.krew/bin ~/.asdf/shims

set -x NNN_PLUG 'f:finder;o:fzopen;c:fzcd'

abbr -a -g e emacsclient -t
abbr -a -g watch viddy

alias cat=bat
alias ls=exa
