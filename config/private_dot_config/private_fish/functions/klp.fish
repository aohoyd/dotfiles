function klp --description "Run stern with tspin for Kubernetes log tailing with pager" --wraps stern
    set -l stern_template '{"message":{{ with $msg := .Message | tryParseJSON }}{{ $.Message }}{{ else }}{{ json .Message }}{{ end }},"pod":"{{.PodName}}","container":"{{.ContainerName}}"{{"}\n"}}'

    # Execute the command with tspin
    tspin --exec "stern --template '$stern_template' $argv"
end
