#!/bin/bash
# This code collects total energies and band gap energies from multiple VASP simulations in subdirectories.

#Final energies
for i in ./* 
do
    if [ -d "$i" ] 
    then
        cd $i
	grep "energy  without entropy=" OUTCAR > sigma
	awk '{ print $7 }' sigma > sigmaf
	tail -1 sigmaf >> ../final-energies.txt
	rm sigma*
	cd ../
    fi
done

#Band gaps
for i in ./*
do
    if [ -d "$i" ]
    then
        cd $i
        awk '176 == NR' EIGENVAL > cbm.txt
	awk '177 == NR' EIGENVAL > vbm.txt
	paste cbm.txt vbm.txt | awk '{print $5 - $2}' > band-gap.txt
	cat band-gap.txt >> ../band-gaps.txt
	rm cbm.txt vbm.txt
	cd ../
    fi
done



