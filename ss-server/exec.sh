#!/bin/bash

ss-manager \
    -m $METHOD \
    -t $TIMEOUT \
    --fast-open \
    -d $DNS_ADDR \
    -d $DNS_ADDR_2 \
    -u \
    --manager-address 0.0.0.0:65000 \
    $ARGS &

ssmgr -c /config/webgui.yml &    

ssmgr -c /config/ss.yml