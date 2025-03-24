# Only execute this file once per shell.
set -q __fish_config_sourced; and exit
set -g __fish_config_sourced 1

status is-login; and begin
    # Login shell initialisation
end

status is-interactive; and begin
    # Abbreviations
    abbr --add -- 9 k9s
    abbr --add -- b br
    abbr --add -- e hx
    abbr --add -- gam 'git amend'
    abbr --add -- gfp 'git fetch -p'
    abbr --add -- gg 'git get'
    abbr --add -- glol 'git log --graph --all --pretty='\''format:%C(auto)%h %C(cyan)%ar %C(auto)(%G?) %C(auto)%d %C(magenta)%an %C(auto)%s'\'''
    abbr --add -- gne 'git next'
    abbr --add -- gpr 'git prev'
    abbr --add -- gs 'git stack'
    abbr --add -- gsy 'git sync'
    abbr --add -- gt 'git tag'
    abbr --add -- gi gitui
    abbr --add -- k kubectl
    abbr --add -- ka 'kubectl apply --recursive -f'
    abbr --add -- kd 'kubectl describe'
    abbr --add -- kdcm 'kubectl describe configmap'
    abbr --add -- kddep 'kubectl describe deployment'
    abbr --add -- kding 'kubectl describe ingress'
    abbr --add -- kdno 'kubectl describe nodes'
    abbr --add -- kdns 'kubectl describe namespaces'
    abbr --add -- kdpo 'kubectl describe pods'
    abbr --add -- kdsec 'kubectl describe secret'
    abbr --add -- kdsvc 'kubectl describe service'
    abbr --add -- ked 'kubectl edit'
    abbr --add -- kex 'kubectl exec -i -t'
    abbr --add -- kg 'kubectl get'
    abbr --add -- kgcm 'kubectl get configmap'
    abbr --add -- kgcmojson 'kubectl get configmap -o=json'
    abbr --add -- kgcmowide 'kubectl get configmap -o=wide'
    abbr --add -- kgcmoyaml 'kubectl get configmap -o=yaml'
    abbr --add -- kgdep 'kubectl get deployment'
    abbr --add -- kgdepojson 'kubectl get deployment -o=json'
    abbr --add -- kgdepowide 'kubectl get deployment -o=wide'
    abbr --add -- kgdepoyaml 'kubectl get deployment -o=yaml'
    abbr --add -- kging 'kubectl get ingress'
    abbr --add -- kgingojson 'kubectl get ingress -o=json'
    abbr --add -- kgingowide 'kubectl get ingress -o=wide'
    abbr --add -- kgingoyaml 'kubectl get ingress -o=yaml'
    abbr --add -- kgno 'kubectl get nodes'
    abbr --add -- kgnoojson 'kubectl get nodes -o=json'
    abbr --add -- kgnoowide 'kubectl get nodes -o=wide'
    abbr --add -- kgnooyaml 'kubectl get nodes -o=yaml'
    abbr --add -- kgns 'kubectl get namespaces'
    abbr --add -- kgnsojson 'kubectl get namespaces -o=json'
    abbr --add -- kgnsowide 'kubectl get namespaces -o=wide'
    abbr --add -- kgnsoyaml 'kubectl get namespaces -o=yaml'
    abbr --add -- kgojson 'kubectl get -o=json'
    abbr --add -- kgojsonf 'kubectl get -o=json --recursive -f'
    abbr --add -- kgowide 'kubectl get -o=wide'
    abbr --add -- kgoyaml 'kubectl get -o=yaml'
    abbr --add -- kgpo 'kubectl get pods'
    abbr --add -- kgpoojson 'kubectl get pods -o=json'
    abbr --add -- kgpoowide 'kubectl get pods -o=wide'
    abbr --add -- kgpooyaml 'kubectl get pods -o=yaml'
    abbr --add -- kgsec 'kubectl get secret'
    abbr --add -- kgsecojson 'kubectl get secret -o=json'
    abbr --add -- kgsecowide 'kubectl get secret -o=wide'
    abbr --add -- kgsecoyaml 'kubectl get secret -o=yaml'
    abbr --add -- kgsvc 'kubectl get service'
    abbr --add -- kgsvcojson 'kubectl get service -o=json'
    abbr --add -- kgsvcowide 'kubectl get service -o=wide'
    abbr --add -- kgsvcoyaml 'kubectl get service -o=yaml'
    abbr --add -- klo 'kubectl logs -f'
    abbr --add -- klop 'kubectl logs -f -p'
    abbr --add -- kn 'kubectl neat'
    abbr --add -- kp 'kubectl proxy'
    abbr --add -- kpf 'kubectl port-forward'
    abbr --add -- krm 'kubectl delete'
    abbr --add -- krmcm 'kubectl delete configmap'
    abbr --add -- krmdep 'kubectl delete deployment'
    abbr --add -- krming 'kubectl delete ingress'
    abbr --add -- krmns 'kubectl delete namespaces'
    abbr --add -- krmpo 'kubectl delete pods'
    abbr --add -- krmsec 'kubectl delete secret'
    abbr --add -- krmsvc 'kubectl delete service'
    abbr --add -- krun 'kubectl run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t'
    abbr --add -- ldo lazydocker
    abbr --add -- lgi lazygit
    abbr --add -- v zed
    abbr --add -- watch viddy

    # Aliases
    alias cat 'bat --theme='\''Monokai Extended'\'' --paging=never'
    alias ls 'eza --group-directories-first'

    # Interactive shell initialisation
    set -x TERM xterm-256color
    set -x GIT_EDITOR hx
    set -x EDITOR hx
    set -x VISUAL zed
    set -x LC_ALL en_US.UTF-8
    set -x K9S_CONFIG_DIR ~/.config/k9s
    set -x BAT_STYLE changes,rule,header,snip

    set -x FZF_DEFAULT_OPTS \
        "--bind=tab:down,shift-tab:up,right:toggle+down,left:toggle+up" \
        "--border=none" \
        "--color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626" \
        "--color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00" \
        "--color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf" \
        "--color=border:#262626,label:#aeaeae,query:#d9d9d9" \
        "--preview-window=\"border-rounded\"" \
        "--prompt=\"> \"" \
        "--marker=\">\"" \
        "--pointer=\"◆\"" \
        "--separator=\"\"" \
        "--scrollbar=\"│\""
    set -x FZF_FIND_FILE_OPTS \
        "--preview \"bat -n --color=always {}\""
    set -x fifc_custom_fzf_opts "+e" "--height=30%" "--preview-window=right,75%"

    fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/coreutils/libexec/gnubin ~/go/bin ~/.krew/bin

    # run starship
    # eval (/opt/homebrew/bin/starship init fish)
    /opt/homebrew/bin/oh-my-posh init fish --config ~/.config/omp.toml | source

    set -x STARSHIP_CONFIG ~/.config/starship.toml
    if test $TERM_PROGRAM = WarpTerminal
        set -x STARSHIP_CONFIG ~/.config/starship-warp.toml
    end

    function rerender_on_dir_change --on-variable PWD
        omp_repaint_prompt
    end

    function __term_setup --on-event fish_prompt -d "Setup term integration"
        functions -e __term_setup

        # Setup prompt marking
        function __term_mark_prompt_start --on-event fish_prompt --on-event fish_cancel --on-event fish_posterror
            # If we never got the output end event, then we need to send it now.
            if test "$__term_prompt_state" != prompt-start
                echo -en "\e]133;D\a"
            end

            set --global __term_prompt_state prompt-start
            echo -en "\e]133;A\a"
        end

        function __term_mark_output_start --on-event fish_preexec
            set --global __term_prompt_state pre-exec
            echo -en "\e]133;C\a"
        end

        function __term_mark_output_end --on-event fish_postexec
            set --global __term_prompt_state post-exec
            echo -en "\e]133;D;$status\a"
        end

        # Report pwd. This is actually built-in to fish but only for terminals
        # that match an allowlist and that isn't us.
        function __update_cwd_osc --on-variable PWD -d 'Notify capable terminals when $PWD changes'
            if status --is-command-substitution || set -q INSIDE_EMACS
                return
            end
            printf \e\]7\;file://%s%s\a $hostname (string escape --style=url $PWD)
        end

        set --global fish_handle_reflow 1

        __term_mark_prompt_start
        __update_cwd_osc
    end
end
