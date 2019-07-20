#!/bin/bash

pidstat -C dejavu -d -r -H -h -p ALL 1 > dejavu.measurement &

for i in {1..9}
do
  echo "Checking log $i"
  dejavu /root/OM/OM-git/medical/dejavu/medical1.qtl /root/OM/OM-git/medical/logs/dejavu/$i.log > /root/OM/OM-git/medical/results/dejavu/1/measurement_log$i.result
  mv /root/OM/OM-git/medical/dejavu/dejavu-results /root/OM/OM-git/medical/results/dejavu/1/dejavu-measurement-$i.result
done

kill -s TERM `pgrep pidstat`
