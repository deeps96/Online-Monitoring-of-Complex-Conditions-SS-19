#!/bin/bash

pidstat -C dejavu -d -r -H -h -p ALL 1 > dejavu-10_5-9.measurement &

for i in {5..9}
do
  echo "Checking log $i"
  dejavu /root/OM/OM-git/medical/dejavu/medical1.qtl /root/OM/OM-git/medical/logs/dejavu/$i.log 10 > /root/OM/OM-git/medical/results/dejavu/1/measurement_10_5-9-log$i.result
  mv /root/OM/OM-git/medical/dejavu/dejavu-results /root/OM/OM-git/medical/results/dejavu/1/dejavu-measurement_10_5-9-$i.result
done

kill -s TERM `pgrep pidstat`
