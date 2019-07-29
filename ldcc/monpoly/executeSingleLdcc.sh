#!/bin/bash

pidstat -C monpoly -d -r -H -h -p ALL 1 > monpoly.measurement &
for l in {1..3}
do
	monpoly -sig /root/OM/OM-git/ldcc/monpoly/ldcc.sig -formula /root/OM/OM-git/ldcc/monpoly/ldcc$l.mfotl -log /root/OM/ldcc-monpoly.csv -negate -stats -mem > /root/OM/OM-git/ldcc/results/monpoly/$l/measurement.result
done
kill -s TERM `pgrep pidstat`
