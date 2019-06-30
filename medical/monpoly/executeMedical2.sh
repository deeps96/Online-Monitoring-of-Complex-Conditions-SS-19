#!/bin/bash
for i in {9..1}
do
  echo "Checking log $i"
  monpoly -sig /root/OM/OM-git/medical/monpoly/medical.sig -formula /root/OM/OM-git/medical/monpoly/medical2.mfotl -negate -log /root/OM/OM-git/medical/logs/monpoly/$i.log -stats -mem > /root/OM/OM-git/medical/results/monpoly/2/log$i.result
done
