#!/bin/bash
# Copyright (C) 2017 Noah Meyerhans <frodo@morgul.net>

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.

# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA

# Run stress. By default, a single CPU worker runs forever. Parameters
# can be overridden via the following environment variables, which
# should be self explanatory based on the stress docs:
# TIMEOUT
# HDD_THREADS
# HDD_BYTES
# IO_THREADS
# CPU_THREADS
# VM_THREADS
# VM_BYTES
# VM_STRIDE
# VM_HANG
# VM_KEEP

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

if [ -n "$VM_THREADS" ]; then
    VM_THREADS_OPT="--vm $VM_THREADS"

    if [ -n "$VM_BYTES" ]; then
	VM_BYTES_OPT="--vm-bytes $VM_BYTES"
    fi
    if [ -n "$VM_STRIDE" ]; then
	VM_STRIDE_OPT="--vm-stride $VM_STRIDE"
    fi
    if [ -n "$VM_HANG" ]; then
	VM_HANG_OPT="--vm-hang $VM_HANG"
    fi
    if [ -n "$VM_KEEP" ]; then
	VM_KEEP_OPT="--vm-keep"
    fi
    VM_OPTS="$VM_THREADS_OPT $VM_BYTES_OPT $VM_STRIDE_OPT"
    VM_OPTS="$VM_OPTS $VM_HANG_OPT $VM_KEEP_OPT"
fi

cat <<EOF
Running with:
CPU spinners: $ACTUAL_CPU_THREADS
HDD threads : ${HDD_THREADS:-0}
HDD bytes   : ${HDD_BYTES:-0}
IO threads  : ${IO_THREADS:-0}
VM threads  : ${VM_THREADS:-0}
EOF

stress --verbose \
       $HDD_OPT \
       $HDD_BYTES_OPT \
       $IO_THREADS_OPT \
       $CPU_THREADS_OPT \
       $VM_OPTS \
       $TIMEOUT_OPT &

stress_pid=$!
cleanup() {
    echo Stopping pid $stress_pid
    kill $stress_pid
}

trap cleanup TERM INT QUIT
wait

end_time=$(date +%s)
echo "Finished after $(($end_time-$start_time))s"
