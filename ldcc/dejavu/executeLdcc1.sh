#!/bin/bash

pidstat -C dejavu -d -r -H -h -p ALL 1 > dejavu.measurement &

  dejavu /root/OM/OM-git/ldcc/dejavu/ldcc1.qtl /root/OM/ldcc-dejavu.csv > /root/OM/OM-git/ldcc/results/dejavu/1/measurement.result
  mv /root/OM/OM-git/ldcc/dejavu/dejavu-results /root/OM/OM-git/ldcc/results/dejavu/1/dejavu-measurement.result

kill -s TERM `pgrep pidstat`
