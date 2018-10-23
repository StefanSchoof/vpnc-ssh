#!/bin/bash
set -e
variables='GATEWAY USERNAME SECRET PASSWORD SSHKEY KNOWNHOSTS'
missingVar=false
for var in $variables
do
  if [ -z "${!var}" ]
  then
    missingVar=true
    echo "$var is missing or has no value"
  fi
done
if [ "$missingVar" = true ]
then
  exit 1
fi
cat > /etc/vpnc/vpn.conf << EOF
IPSec gateway $GATEWAY
IPSec ID $USERNAME
IPSec secret $SECRET
IKE Authmode psk
Xauth username $USERNAME
Xauth password $PASSWORD
local port 0
DPD idle timeout (our side) 0
EOF
echo "$SSHKEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
echo "$KNOWNHOSTS" > /root/.ssh/known_hosts
vpnc vpn
exec "$@"
