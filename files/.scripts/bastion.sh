#!/bin/bash
while :
do
  date
  ssh -v -N \
    -o ExitOnForwardFailure=yes \
    -R 11922:localhost:22 \
    -R 11980:localhost:8080 \
    -R 11988:localhost:8088 \
    bastion
  echo Reconnecting...
  sleep 20
done

