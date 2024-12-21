function kva --wraps="kubectl get secret"
    kubectl view-secret --all $argv
end
