#!/bin/bash

start_time=$(date +%s)

if [ -n "$TIMEOUT" ]; then
    TIMEOUT_OPT="--timeout $TIMEOUT"
fi

if [ -n "$HDD_THREADS" ]; then
    HDD_OPT="--hdd $HDD_THREADS"
fi

if [ -n "$HDD_BYTES" ]; then
    HDD_BYTES_OPT="--hdd-bytes $HDD_BYTES"
fi

if [ -n "$IO_THREADS" ]; then
    IO_THREADS_OPT="--io $IO_THREADS"
fi

if [ -n "$CPU_THREADS" ]; then
    CPU_THREADS_OPT="--cpu $CPU_THREADS"
fi

stress $HDD_OPT \
       $HDD_BYTES_OPT \
       $IO_THREADS_OPT \
       $CPU_THREADS_OPT \
       $TIMEOUT_OPT

end_time=$(date +%s)
echo "Finished after $(($end_time-$start_time))s"
