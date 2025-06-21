function ks
    # Parse arguments using argparse
    set -l context $argv[1]
    set -l namespace $argv[2]

    # Check for multiple positional arguments
    if test (count $argv) -gt 2
        echo "Error: too many arguments" >&2
        return 1
    end

    # Case 1: No arguments - interactive context selection
    if test -z "$argv[1]"
        _kswitch_interactive
        return $status
    end

    # Case 2: Context specified (with optional namespace)
    if test -n "$argv[1]"
        _kswitch_set_context "$argv[1]" "$argv[2]"
        return $status
    end
end

function kns
    # Parse arguments using argparse
    set -l namespace $argv[1]

    # Check for multiple positional arguments
    if test (count $argv) -gt 1
        echo "Error: too many arguments" >&2
        return 1
    end

    # Case 1: No arguments - interactive namespace selection
    if test -z "$argv[1]"
        _kswitch_namespace_interactive
        return $status
    end

    # Case 2: Set specific namespace
    if test -n "$argv[1]"
        _kswitch_set_namespace_current "$argv[1]"
        return $status
    end
end

function _kswitch_get_kubeconfig_files
    set -l files

    # Add default config if it exists
    if test -f ~/.kube/config
        printf '%s\n' ~/.kube/config
    end

    fd --search-path ~/.kube/configs/ -t file --absolute-path
end

function _kswitch_get_contexts
    yq ea '[{"file": filename, "contexts": .contexts}][]
        | .contexts |= (
            with(select(type == "!!seq"); . = [.[].name])
            | with(select(type == "!!map"); . = keys))
        | select(.contexts | length != 0)
        | .file + ":" + .contexts[]
    ' (_kswitch_get_kubeconfig_files)
end

function _kswitch_get_contexts_from_file
    set -l file $argv[1]
    if test -f "$file"
        KUBECONFIG="$file" kubectl config get-contexts -oname || true
    end
end

function _kswitch_find_context_file
    set -l target_context $argv[1]

    for file_context in (_kswitch_get_contexts)
        set -l pair (string split -m1 ':' "$file_context")
        set -l file $pair[1]
        set -l context $pair[2]
        if test "$context" = "$target_context"
            echo "$file"
            return 0
        end
    end

    return 1
end

function _kswitch_get_namespaces
    kubectl get namespaces -o name 2>/dev/null | string replace namespace/ ''
end

function _kswitch_interactive
    # Collect all contexts with their source files into single array
    set -l context_list (_kswitch_get_contexts)

    if test (count $context_list) -eq 0
        echo "No contexts found in kubeconfig files" >&2
        return 1
    end

    # Use fzf to select context
    set -l selection (printf '%s\n' $context_list | fzf --delimiter=':' --with-nth=2.. --preview 'bat --color=always --language=yaml {1}' --height 30% --min-height 10)

    if test -z "$selection"
        echo "No context selected"
        return 1
    end

    # Parse the selection to get file and context
    set -l selected_pair (string split -m1 ':' "$selection")
    set -l selected_file $selected_pair[1]
    set -l selected_context $selected_pair[2]

    set -gx KUBECONFIG "$selected_file"
    kubectl config use-context "$selected_context"
end

function _kswitch_namespace_interactive
    # Collect all contexts with their source files into single array
    set -l ns_list (_kswitch_get_namespaces)

    if test (count $ns_list) -eq 0
        echo "No namespaces found" >&2
        return 1
    end

    # Use fzf to select ns
    set -l selection (printf '%s\n' $ns_list | fzf --height 30% --min-height 10)

    if test -z "$selection"
        echo "No namespace selected"
        return 1
    end

    set -l selected_ns $selection
    _kswitch_set_namespace_current "$selected_ns"
end

function _kswitch_set_namespace_current
    kubectl config set-context --current --namespace="$argv[1]" 1>/dev/null
    or return 1
    echo "switched to \"$argv[1]\" namespace"
end

function _kswitch_set_context
    set -l context $argv[1]
    set -l namespace $argv[2]

    # Find which file contains this context
    set -l config_file (_kswitch_find_context_file "$context")

    if test -z "$config_file"
        echo "Error: Context '$context' not found in any kubeconfig file" >&2
        return 1
    end

    # Export KUBECONFIG and switch context
    set -gx KUBECONFIG "$config_file"
    kubectl config use-context "$context" >/dev/null 2>&1
    if test -n "$namespace"
        kubectl config set-context --current --namespace="$argv[2]" >/dev/null 2>&1
    else
        set namespace (kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
        if test -z "$namespace"
            set namespace default
        end
    end

    echo "switched to \"$context\" context \"$namespace\" namespace"
end

# Helper function to display current context info
function kswitch-info
    echo "Current KUBECONFIG: $KUBECONFIG"
    if test -n "$KUBECONFIG" -a -f "$KUBECONFIG"
        echo "Current context: $(kubectl config current-context 2>/dev/null || echo 'none')"
        set -l current_ns (kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
        if test -n "$current_ns"
            echo "Current namespace: $current_ns"
        else
            echo "Current namespace: default"
        end
    else
        echo "No valid KUBECONFIG set"
    end
end
