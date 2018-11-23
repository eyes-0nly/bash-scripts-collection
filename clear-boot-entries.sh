#!/bin/sh

for entry in "$@"
do
wc efibootmgr -b $entry -B
done
