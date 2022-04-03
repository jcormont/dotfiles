#!/bin/bash
while :
do
  date
  ssh -v -N \
    -o ExitOnForwardFailure=yes \
    -R 11922:localhost:22 \
    bastion
  echo Reconnecting...
  sleep 20
done

