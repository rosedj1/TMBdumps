#!/bin/bash
dir1="sub_scripts/"
# Make list of numbers of the measurements, e.g. 4400, 4402, 4404
measlist="$(awk '{print $1}' "$dir1"meta)"

# User enters password to ssh into emugif2. Be sure to use 3 escape characters when supplying PW
echo "Enter password for emugif2"
read -s pass

# Make sure tmb doesn't have old TMB dumps in it
rm ./tmb/*
cd tmb
for meas in $measlist
do
	datestr=$(awk '/^'$meas'.*STEP_40/ {sub(/emugif2.*STEP_40_000_/,"",$NF); sub(/_UTC\.raw/,"",$NF); print $NF}' ../"$dir1"meta)
	if [ -z "$datestr" ]
	then
		continue
	fi
	##### I FOUND IT! THIS IS WHERE ME21 GETS ADDED TO THE NAME AUTOMATICALLY! Is the extra space after _UTC.txt necessary?
	##### In meta, Field 3 = Voltage; F7,8 = identifying file numbers, like 171842_886934
	##### FIX SOURCE OFF. Should be easy F3,4 indicate beam/source
	##### var chamber is imported from ./MasterPlotter ME[12]1 
	../"$dir1"autopass.sh "$pass" "scp localuser@emugif2.cern.ch:/raid/data/current/TMBCounters_GIF++_Test40_${datestr}_UTC.txt "m${meas}_"$chamber"_$(awk '/'$meas'/ {print $3}' ../"$dir1"meta)_test40_SRCoff_$(awk 'BEGIN{FS="_"; OFS="_"} /^'$meas'/ {print $7,$8}' ../"$dir1"meta)_TMBCounters.txt
done
# Get out of tmb/ and go back to PACKAGE
cd ..
