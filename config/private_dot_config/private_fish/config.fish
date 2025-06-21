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
    set -x PAGER "ov -F"
    set -x TAILSPIN_PAGER "ov -f [FILE]"

    set -x FZF_DEFAULT_OPTS \
        "--bind=tab:down,shift-tab:up,right:toggle+down,left:toggle+up" \
        "--border=none" \
        "--color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626" \
        "--color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00" \
        "--color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf" \
        "--color=border:#262626,label:#aeaeae,query:#d9d9d9" \
        "--preview-window=\"border-rounded\"" \
        "--prompt=\" > \"" \
        "--marker=\" >\"" \
        "--pointer=\"◆\"" \
        "--separator=\"\"" \
        "--scrollbar=\"│\""
    set -x FZF_FIND_FILE_OPTS \
        "--preview \"bat -n --color=always {}\""
    set -x fifc_custom_fzf_opts "+e" "--height=30%" "--preview-window=right,75%"

    fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/coreutils/libexec/gnubin ~/go/bin ~/.krew/bin

    # run starship
    # function starship_transient_prompt_func
    #     starship module character
    # end
    # /opt/homebrew/bin/starship init fish | source
    # enable_transience
    /opt/homebrew/bin/oh-my-posh init fish --config ~/.config/omp.toml | source

    function rerender_on_dir_change --on-variable PWD
        omp_repaint_prompt
    end

    function __term_setup --on-event fish_prompt -d "Setup term integration"
        functions -e __term_setup

        # Setup prompt marking
        function __term_mark_prompt_start --on-event fish_prompt --on-event fish_cancel --on-event fish_posterror
            # If we never got the output end event, then we need to send it now.
            if test "$__term_prompt_state" != prompt-start
                echo -en "\e]133
    D\a"
            end

            set --global __term_prompt_state prompt-start
            echo -en "\e]133
    A\a"
        end

        function __term_mark_output_start --on-event fish_preexec
            set --global __term_prompt_state pre-exec
            echo -en "\e]133
    C\a"
        end

        function __term_mark_output_end --on-event fish_postexec
            set --global __term_prompt_state post-exec
            echo -en "\e]133
    D
$status\a"
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

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
