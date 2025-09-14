#!/usr/bin/env bash

yum install -y awslogs jq

region=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
sed -i -e "s/region = us-east-1/region = $region/g" /etc/awslogs/awscli.conf

mv -rf /etc/awslogs/awslogs.conf /etc/awslogs/awslogs.conf.bak

cat << EOF > /etc/awslogs/awslogs.conf
[general]
state_file = /var/lib/awslogs/agent-state
EOF

mkdir -p /etc/awslogs/config-templates
cat << EOF > /etc/awslogs/config-templates/system.conf
[/var/log/dmesg]
file = /var/log/dmesg
log_group_name = {application}-{environment}-{role}
log_stream_name = {container_instance_id}-system-dmesg

[/var/log/messages]
file = /var/log/messages
log_group_name = {application}-{environment}-{role}
log_stream_name = {container_instance_id}-system-messages
datetime_format = %b %d %H:%M:%S
EOF

cat << EOF > /etc/awslogs/config-templates/ecs.conf
[/var/log/docker]
file = /var/log/docker
log_group_name = {application}-{environment}-{role}
log_stream_name = {container_instance_id}-docker
datetime_format = %Y-%m-%dT%H:%M:%S.%f

[/var/log/ecs/ecs-init.log]
file = /var/log/ecs/ecs-init.log.*
log_group_name = {application}-{environment}-{role}
log_stream_name = {container_instance_id}-ecs-init
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/ecs/ecs-agent.log]
file = /var/log/ecs/ecs-agent.log.*
log_group_name = {application}-{environment}-{role}
log_stream_name = {container_instance_id}-ecs-agent
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/ecs/audit.log]
file = /var/log/ecs/audit.log.*
log_group_name = {application}-{environment}-{role}
log_stream_name = {container_instance_id}-ecs-audit
datetime_format = %Y-%m-%dT%H:%M:%SZ
EOF
