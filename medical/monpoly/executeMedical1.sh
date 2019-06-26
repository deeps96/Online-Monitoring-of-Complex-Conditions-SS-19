#!/bin/bash
for i in {9..5}
do
  echo "Checking log $i"
  monpoly -sig /root/OM/OM-git/medical/monpoly/medical.sig -formula /root/OM/OM-git/medical/monpoly/medical1.mfotl -negate -log /root/OM/OM-git/medical/logs/monpoly/$i.log -stats -mem > /root/OM/OM-git/medical/results/monpoly/1/log$i.result
done
