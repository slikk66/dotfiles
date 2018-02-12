#!/bin/bash

# Requires cli53 (i.e. `brew install cli53` on mac)

# Update these values for yourself
export AWS_PROFILE='billeci.iamdan'
ZONE="Z2C9N0B23WOE1Z"
HOSTNAME="dynamichost"
# this would configure dynamichost.mydomain.com with your current public IP

export PATH="/usr/local/bin:/usr/bin/:$PATH"
REMOTE_IP=$(curl -s ipecho.net/plain)
CURRENT_VALUE=$(dig +short $HOSTNAME.$ZONE)

if [[ $REMOTE_IP =~ [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]] ; then
    if [[ $CURRENT_VALUE != $REMOTE_IP ]] ; then
        cli53 rrcreate --replace $ZONE "$HOSTNAME 60 A $REMOTE_IP"
    fi
fi
