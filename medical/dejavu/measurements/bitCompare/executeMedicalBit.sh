#!/bin/bash

for b in 6 10 14 18
do
  pidstat -C dejavu -d -r -H -h -p ALL 1 > dejavu-$b.measurement &

  for i in {9..4}
  do
    echo "Checking log $i"
    dejavu /root/OM/OM-git/medical/dejavu/medical1.qtl /root/OM/OM-git/medical/logs/dejavu/$i.log $b > /root/OM/OM-git/medical/results/dejavu/1/measurement_$b-log$i.result
    mv /root/OM/OM-git/medical/dejavu/dejavu-results /root/OM/OM-git/medical/results/dejavu/1/dejavu-measurement_$b-$i.result
  done

  kill -s TERM `pgrep pidstat`
done
