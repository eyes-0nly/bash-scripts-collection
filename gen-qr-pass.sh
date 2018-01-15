#!/usr/bin/env sh

OPT=$(getopt -o skh --long strong,help,keep -n 'gen-qr-pass.sh' -- "$@")
if [ $? != 0 ] ; then echo "script usage: $(basename $0) [ -s --strong (strong password with special characters)] [-h --help ] [-k --keep (keep password on the output)] [ password_length ]" >&2 ; exit 1 ; fi
eval set -- "$OPT"
STRONG=false
USAGE=false
KEEP=false
while true ; do
    case "$1" in
    -s|--strong)
      STRONG=true ; shift
    ;;

    -h|--help)
      USAGE=true ; shift
    ;;

    -k|--keep)
      KEEP=true ; shift
    ;;

    --) shift; break ;;

    *) break ;;
  esac
done
shift "$(($OPTIND -1))"
LENGTH="$*"
if [ "$*" == "" ] ; then echo "script usage: $(basename $0) [ -s --strong (strong password with special characters)] [-h --help ] [-k --keep (keep password on the output)] [ password_length ]" >&2 ; exit 1 ; fi
if [[ "$USAGE" = false ]]; then
if [[ "$LENGTH" -gt 0 && "$STRONG" = true ]] ;then
PASSWORD=$(pwgen -sync $LENGTH 1)
qrencode -s 10 "$PASSWORD" -o qrpass.png
else
if [[ "$LENGTH" -gt 0 && "$STRONG" = false ]] ;then
PASSWORD=$(pwgen -snc $LENGTH 1)
qrencode -s 10 "$PASSWORD" -o qrpass.png
fi
fi
if [[ "$KEEP" = true ]]; then
echo "$PASSWORD"
fi
display qrpass.png
shred -n 30 -u qrpass.png
echo "Done"
else
echo "script usage: $(basename $0) [ -s --strong (strong password with special characters)] [-h --help ] [-k --keep (keep password on the output)] [ password_length ]" >&2
exit 1
fi
