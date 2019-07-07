#!/bin/bash

usage()
{
  echo "usage: executeMedical [[[-l] [-s] [-p] [-i]] | [-h]]"
  echo "  -h\t--help\t\tDisplay this usage description"
  echo "  -i\t--identifier\tUnique string to identify execution"
  echo "  -l\t--log\t\tMedical case: 1-9"
  echo "  -p\t--property\t1 or 2"
  echo "  -s\t--script\te.g. monpoly1test.mfotl"
}

if [ $# != 8 ]; then
  usage
  exit 1
fi

while [ "$1" != "" ]; do
  case $1 in
    -l | --log )         shift
                         LOG_NUMBER=$1
                         ;;
    -s | --script )      shift
                         SCRIPT_TITLE=$1
                         ;;
    -p | --property )    shift
                         PROPERTY_NUMBER=$1
                         ;;
    -i | --identifier )  shift
                         IDENTIFIER=$1
                         ;;
    -h | --help )        usage
                         exit
                         ;;
    * )                  usage
                         exit 1
  esac
  shift
done

monpoly -sig /root/OM/OM-git/medical/monpoly/medical.sig -formula /root/OM/OM-git/medical/monpoly/$SCRIPT_TITLE -negate -log /root/OM/OM-git/medical/logs/monpoly/$LOG_NUMBER.log -stats -mem > /root/OM/OM-git/medical/results/monpoly/$PROPERTY_NUMBER/log$LOG_NUMBER\_$IDENTIFIER.result

