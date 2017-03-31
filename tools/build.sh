#!/bin/bash
set -o errexit
set -o nounset

cd -P -- "$(dirname -- "$0")" #go to dir of script even if it was called as a symbolic link
cd ..

docker build --tag mmaas3/scaffoldtest --squash .
c=$(docker run --rm -d mmaas3/scaffoldtest:buildbase tail -f /dev/null)
docker cp /yarn.lock:./yarn.lock $c
docker stop $c
docker rm $c
