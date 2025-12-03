function __fzf_rg
    rm -f /tmp/rg-fzf-{r,f}
    set -l RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
    fzf --ansi --disabled --query "$argv" \
        --bind "start:reload:$RG_PREFIX {q}" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --bind 'ctrl-t:transform:string match -q -- "*fzf*" $FZF_PROMPT &&
      echo "rebind(change)+change-prompt(1. ripgrep> )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; /bin/cat /tmp/rg-fzf-r" ||
      echo "unbind(change)+change-prompt(2. fzf> )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; /bin/cat /tmp/rg-fzf-f"' \
        --prompt '1. ripgrep> ' \
        --delimiter : \
        --header 'CTRL-T: Switch between ripgrep/fzf' \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --bind 'enter:become($EDITOR {1} +{2})'
end
