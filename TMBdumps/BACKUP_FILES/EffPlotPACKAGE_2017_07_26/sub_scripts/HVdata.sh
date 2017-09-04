#!/bin/bash
# SYNTAX: ./HVdata.sh
# PURPOSE: Create file with list of measurements to-be-processed (measfile.txt).
# Each measurements resides in /tmb/. Also create column of HV values (HV_values.txt).
# Jake R., 2017-07-21

# Make file of measurements
ls -1 ./tmb/ > measfile.txt

#Make file of HV values
awk -F '_' '{if ($3=="HV0" && $2=="ME11") print "2869"; else if ($3=="HV0" && $2=="ME21") print "3602"; else print $3}' measfile.txt > HV_values.txt
