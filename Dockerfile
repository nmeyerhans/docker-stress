FROM debian

RUN apt-get update && apt-get -y install stress && apt-get clean

COPY stress.sh /entrypoint

ENTRYPOINT ["/entrypoint"]
