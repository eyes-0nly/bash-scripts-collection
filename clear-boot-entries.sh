#!/bin/sh

for entry in "$@"
do
efibootmgr -b $entry -B
done
