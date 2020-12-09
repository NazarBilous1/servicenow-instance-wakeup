#!/bin/bash

# shellcheck disable=SC1097
/app/servicenow-instance-wakeup -config=/app/config.json -timeout=300 -headless=true
