#!/bin/bash

tr -d '\r' | sed '/^#/ d' | awk NF | tr -s ' ' | tr ' ' ',' > measurement.csv