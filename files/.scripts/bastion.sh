#!/bin/bash
while :
do
  date
  ssh -v -N \
    -o ExitOnForwardFailure=yes \
    -R 11922:localhost:22 \
    -R 3389:localhost:3389 \
    bastion
  echo Reconnecting...
  sleep 20
done

