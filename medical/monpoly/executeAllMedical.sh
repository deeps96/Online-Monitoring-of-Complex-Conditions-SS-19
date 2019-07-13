#!/bin/bash

IDENTIFIER=`cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1`

usage()
{
  echo -e "usage: executeMedical [[[-s] [-p]] | [-h]]"
  echo -e "  -h\t--help\t\tDisplay this usage description"
  echo -e "  -p\t--property\t1 or 2"
  echo -e "  -s\t--script\te.g. monpoly1test.mfotl"
}

if [ $# != 4 ]; then
  usage
  exit 1
fi

while [ "$1" != "" ]; do
  case $1 in
    -s | --script )      shift
                         SCRIPT_TITLE=$1
                         ;;
    -p | --property )    shift
                         PROPERTY_NUMBER=$1
                         ;;
    -h | --help )        usage
                         exit
                         ;;
    * )                  usage
                         exit 1
  esac
  shift
done

echo "Identifier: $IDENTIFIER"

touch $IDENTIFIER\_$SCRIPT_TITLE

pidstat -C monpoly -d -r -H -h -p ALL 1 > $IDENTIFIER.measurement &

for l in {1..9}
do
  echo "Checking log $l"
  ./executeSingleMedical.sh -i $IDENTIFIER -l $l -p $PROPERTY_NUMBER -s $SCRIPT_TITLE
done

kill -s TERM `pgrep pidstat`

