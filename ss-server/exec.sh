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

ssmgr -c /webgui.yml &    

ssmgr -c /ss.yml