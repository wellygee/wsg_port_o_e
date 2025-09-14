#!/usr/bin/env bash

cat << EOF > /etc/environment
APPLICATION="${application}"
ENVIRONMENT="${environment}"
ROLE="${role}"
EOF

source /etc/environment