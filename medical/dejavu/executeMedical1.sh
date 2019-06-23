#!/bin/bash
for i in {1..9}
do
  echo "Checking log $i"
  dejavu /root/OM/OM-git/medical/dejavu/medical1.qtl /root/OM/OM-git/medical/logs/dejavu/$i.log > /root/OM/OM-git/medical/results/dejavu/1/log$i.result
done
