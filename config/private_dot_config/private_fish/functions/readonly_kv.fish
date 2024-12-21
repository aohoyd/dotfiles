function kv --wraps="kubectl get secret"
    kubectl view-secret $argv
end
