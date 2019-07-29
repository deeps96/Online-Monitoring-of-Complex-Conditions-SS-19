#!/bin/bash

pidstat -C dejavu -d -r -H -h -p ALL 1 > dejavu-14_all.measurement &

for i in {1..9}
do
  echo "Checking log $i"
  dejavu /root/OM/OM-git/medical/dejavu/medical1.qtl /root/OM/OM-git/medical/logs/dejavu/$i.log 14 > /root/OM/OM-git/medical/results/dejavu/1/measurement_14_all-log$i.result
  mv /root/OM/OM-git/medical/dejavu/dejavu-results /root/OM/OM-git/medical/results/dejavu/1/dejavu-measurement_14_all-$i.result
done

kill -s TERM `pgrep pidstat`
