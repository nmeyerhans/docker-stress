Docker Stress
=============

This is a simple wrapper around the
[stress](http://people.seas.harvard.edu/~apw/stress/) synthetic system
workload generator. I've found it occasionally useful when testing
system behavior under load, for example when tuning Docker container
resource limits.

By default, a single CPU worker runs forever. Parameters can be overridden via
the following environment variables, which should be self explanatory based on
the stress docs, or by passing stress command line options directly on the
'docker run' invocation.

* TIMEOUT
* HDD_THREADS
* HDD_BYTES
* IO_THREADS
* CPU_THREADS
* VM_THREADS
* VM_BYTES
* VM_STRIDE
* VM_HANG
* VM_KEEP

Images can be pulled from Docker Hub at
[nmeyerhans/stress](https://hub.docker.com/r/nmeyerhans/stress/)

