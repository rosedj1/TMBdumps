#!/bin/bash
# SYNTAX: ./Choppa.sh
# PURPOSE: Look at a measurement in filtered_tmb/ and chop it up into the important quantities. 
# List each quantity in its own column. Do this for each measurement.
# Jake, 2017-07-13

filt_dir="./filtered_tmb/"
proc_dir="./processed_tmb/"

# Define function awkit() to pull the desired data
# SYNTAX: awkItHeader() takes three arguments:   search_pattern   field_with_data   file_to_be_awked
headerAwk() 
{
	( echo "$1" ; awk "/$1/ {print $2}" "$filt_dir"$3 ) >> "$proc_dir"dummy"$name";
}

# Needs extra echo so that formatting is "on level" with first column.
AwkThenPaste()
{
	((name++))
	(echo; echo "$1" ; awk "/$1/ {print $2}" "$filt_dir"$3 ) >> "$proc_dir"dummy"$name";

	paste "$proc_dir"dummy$((name-1)) "$proc_dir"dummy"$name" >> "$proc_dir"dummy$((name+1));
	((name++))
}

footerAwkPaste()
{
	((name++))
	(echo; echo "$1" ; awk "/$1/ {print $2}" "$filt_dir"$3 ) >> "$proc_dir"dummy"$name";

	# Make the file which will survive. Replace "filtered_" with "processed_"
	paste "$proc_dir"dummy$((name-1)) "$proc_dir"dummy"$name" > "$proc_dir""${meas/filtered/processed}"
}

# First, clean out processed_tmb/
rm processed_tmb/*

# List all measurements in /filtered_tmb/ (they have the name format: filtered_m*)
list=$( ls "$filt_dir" )

# For each meas, grab the important quantities, make a new file whose name is +1 the old file's name, drop it in /processed_tmb/.
for meas in $list
do
name=0;
	# Create dummy files to paste together at the end
	# Write over previous dummy file (if it exists) and indicate which processed meas. Then fill 'er up with data.
	echo "${meas/filtered/processed}" > "$proc_dir"dummy"$name";

	headerAwk 'alct0 valid pattern flag received' '$7' "$meas"

	AwkThenPaste 'alct1 valid pattern flag received' '$7' "$meas"

	AwkThenPaste 'raw hits readout   ' '$5' "$meas"

	AwkThenPaste 'Pretrigger   ' '$3' "$meas"

	AwkThenPaste 'Pretrigger on CFEB0' '$5' "$meas"

	AwkThenPaste 'Pretrigger on CFEB1' '$5' "$meas"

	AwkThenPaste 'Pretrigger on CFEB2' '$5' "$meas"

	AwkThenPaste 'Pretrigger on CFEB3' '$5' "$meas"

	AwkThenPaste 'Pretrigger on CFEB4' '$5' "$meas"

	AwkThenPaste 'Pretrigger on CFEB5' '$5' "$meas"

	AwkThenPaste 'Pretrigger on CFEB6' '$5' "$meas"

	AwkThenPaste 'Pretrigger on ME1A CFEB 4-6 only' '$8' "$meas"	### N.B.! Typo in TMB dumps! CFEB here is singular.

	AwkThenPaste 'Pretrigger on ME1B CFEBs 0-3 only' '$8' "$meas"

	AwkThenPaste 'Discarded, CLCT0 invalid pattern after drift' '$8' "$meas"

	AwkThenPaste 'BX pretrig waiting for triads to dissipate' '$9' "$meas"

	AwkThenPaste 'clct0 sent to TMB matching section' '$8' "$meas"

	AwkThenPaste 'clct1 sent to TMB matching section' '$8' "$meas"

	AwkThenPaste 'TMB accepted alct' '$8' "$meas"		#Needs this special search pattern?

	AwkThenPaste 'TMB match reject event  ' '$6' "$meas"

	AwkThenPaste 'Matching found one ALCT' '$6' "$meas"

	AwkThenPaste 'Matching found one CLCT' '$6' "$meas"

	AwkThenPaste 'Matching found two ALCTs' '$6' "$meas"

	AwkThenPaste 'Matching found two CLCTs' '$6' "$meas"

	AwkThenPaste 'ALCT0 copied into ALCT1 to make 2nd LCT' '$10' "$meas"

	AwkThenPaste 'CLCT0 copied into CLCT1 to make 2nd LCT' '$10' "$meas"

	AwkThenPaste 'LCT1 has higher quality than LCT0 ' '$10' "$meas"

	AwkThenPaste 'Transmitted LCT0 to MPC' '$6' "$meas"

	AwkThenPaste 'Transmitted LCT1 to MPC' '$6' "$meas"

	AwkThenPaste 'MPC rejected both LCT0 and LCT1' '$8' "$meas"

	AwkThenPaste 'L1A received   ' '$4' "$meas"

	AwkThenPaste 'L1A received, TMB in L1A window' '$8' "$meas"

	AwkThenPaste 'L1A received, no TMB in window' '$8' "$meas"

	AwkThenPaste 'TMB triggered, no L1A in window' '$8' "$meas"

	AwkThenPaste 'TMB readouts completed' '$5' "$meas"

	AwkThenPaste 'Pretrigger counter   ' '$4' "$meas"

	AwkThenPaste 'CLCT counter   ' '$4' "$meas"

	AwkThenPaste 'TMB trigger counter' '$5' "$meas"

	AwkThenPaste 'ALCTs received counter' '$5' "$meas"

	AwkThenPaste 'L1As received counter ' '$7' "$meas"

	AwkThenPaste 'Readout counter ' '$6' "$meas"

	AwkThenPaste 'Orbit counter' '$4' "$meas"

	AwkThenPaste 'CLCT pre-trigger and ALCT coincidence counter' '$8' "$meas"

	AwkThenPaste 'CFEB0 active flag sent to DMB for readout' '$10' "$meas"

	AwkThenPaste 'CFEB1 active flag sent to DMB for readout' '$10' "$meas"

	AwkThenPaste 'CFEB2 active flag sent to DMB for readout' '$10' "$meas"

	footerAwkPaste 'CFEB3 active flag sent to DMB for readout' '$10' "$meas"

	# Remove all dummy files.
	rm "$proc_dir"dummy*
done

# Combine all processed_m* files into one big-ass file. 
list=$( ls "$proc_dir" ) 
echo -n >massivefile.txt
for meas in $list 
do 
	( cat "$proc_dir""$meas" ; echo ) >> massivefile.txt 
done
