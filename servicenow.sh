#!/bin/bash

# shellcheck disable=SC1097
go run /app/servicenow-instance-wakeup.go -config=/app/config.json -timeout=300
