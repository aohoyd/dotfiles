function khl --description "Run stern with tspin for Kubernetes log tailing" --wraps stern
    set -l stern_template '{"message":{{ with $msg := .Message | tryParseJSON }}{{ $.Message }}{{ else }}{{ json .Message }}{{ end }},"pod":"{{.PodName}}","container":"{{.ContainerName}}"{{"}\n\n"}}'

    # Execute the command with tspin
    tspin --print --follow --exec "stern --template '$stern_template' $argv | hl -P"
end
