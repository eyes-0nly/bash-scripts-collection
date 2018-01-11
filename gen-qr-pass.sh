#!/usr/bin/env sh
length=$1
# Check if special chars required
if [[ "$2" == "strong" ]]; then
pwgen -sync $length 1 | qrencode -s 10 -o qrpass.png
display qrpass.png
shred -v -n 30 -u qrpass.png
echo "Done."
else
pwgen -snc $length 1 | qrencode -s 10 -o qrpass.png
display qrpass.png
shred -v -n 30 -u qrpass.png
echo "Done."
fi
