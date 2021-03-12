#!/bin/sh
# This script processes cell vectors and MD energies following an NPT molecular dynamics simulation in DFTB+.


grep "Potential Energy:" md.out > potential-energy.log

#Lattice vector A
awk '10 == NR % 18' md.out > cell-vector-a.log

#Lattice vector B
awk '11 == NR % 18' md.out > cell-vector-b.log

#Lattice vector C
awk '12 == NR % 18' md.out > cell-vector-c.log

paste cell-vector-a.log cell-vector-b.log cell-vector-c.log potential-energy.log | awk '{print $1 "," $5 "," $9 "," $14}' > dftb-npt.csv

rm cell-vector-a.log cell-vector-b.log cell-vector-c.log potential-energy.log
