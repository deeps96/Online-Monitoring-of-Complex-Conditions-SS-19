#!/bin/bash

for b in 6 10 14 18
do
  pidstat -C dejavu -d -r -H -h -p ALL 1 > dejavu-$b.measurement &

  dejavu /root/OM/OM-git/ldcc/dejavu/ldcc1.qtl /root/OM/ldcc-dejavu.csv $b > /root/OM/OM-git/ldcc/results/dejavu/1/measurement_$b.result
  mv /root/OM/OM-git/ldcc/dejavu/dejavu-results /root/OM/OM-git/ldcc/results/dejavu/1/dejavu-measurement_$b.result

  kill -s TERM `pgrep pidstat`
done
