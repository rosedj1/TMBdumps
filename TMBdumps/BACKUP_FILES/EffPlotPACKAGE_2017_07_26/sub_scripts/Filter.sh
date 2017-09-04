#!/bin/bash
# PURPOSE: Scan through each tmb/m*TMBCounters.txt and extract only the data of interest (either ME11 or ME21 depending on file name).
# SYNTAX: ./Separator.sh

# Because of the goofy new format in TMB dumps, ME11 and ME21 data are mixed! 
# I need to select ONLY one of the chambers' data.
# Have the program look into measfile.txt and identify which chamber is being analyzed.
# The awk cmd will spit out either ME11 or ME21 and the sed cmd edits it to ME+1/1 or ME+2/1, respectively.
chamber="$(awk -F'_' END'{print $2}' measfile.txt | sed 's:ME\([12]\):ME\\+\1\\/:')"

# Clean out filtered_tmb/
rm filtered_tmb/*

# Separate out the ME11 and ME21 spill sets. Put the spill sets of interest into filtered_tmb/
list=$( ls ./tmb/ )
for meas in $list
do
        awk "/$chamber/, /===/" ./tmb/$meas > ./filtered_tmb/filtered_$meas
done
