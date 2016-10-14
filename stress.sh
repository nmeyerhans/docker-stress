#!/bin/bash

if [ -n "$TIMEOUT" ]; then
    TIMEOUT_OPT="--timeout $TIMEOUT"
fi

stress --hdd ${HDD_THREADS:-2} \
       --hdd-bytes ${HDD_BYTES:-100K} \
       --io ${IO_THREADS:-1} \
       $TIMEOUT_OPT
