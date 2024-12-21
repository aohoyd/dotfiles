function ny
    argparse e/expand= -- $argv
    or return
    set -l cmd "cat | from yaml"
    if count $argv >/dev/null
        set cmd "$cmd | $argv[1]"
    end
    if set -ql _flag_expand
        set cmd "$cmd | table --expand --expand-deep $_flag_expand"
    end
    nu -c $cmd
end
