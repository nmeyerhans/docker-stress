#!/bin/bash
# Run stress. By default, a single CPU worker runs forever. Parameters
# can be overridden via the following environment variables, which
# should be self explanatory based on the stress docs:
# TIMEOUT
# HDD_THREADS
# HDD_BYTES
# IO_THREADS
# CPU_THREADS

start_time=$(date +%s)

ACTUAL_CPU_THREADS=${CPU_THREADS:-1}

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

if [ "$ACTUAL_CPU_THREADS" -gt 0 ]; then
    CPU_THREADS_OPT="--cpu $ACTUAL_CPU_THREADS"
fi

stress $HDD_OPT \
       $HDD_BYTES_OPT \
       $IO_THREADS_OPT \
       $CPU_THREADS_OPT \
       $TIMEOUT_OPT

end_time=$(date +%s)
echo "Finished after $(($end_time-$start_time))s"
