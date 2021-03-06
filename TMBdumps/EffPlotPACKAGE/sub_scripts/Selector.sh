#!/bin/bash
# SYNTAX: ./Selector.sh
# PURPOSE: Create a file of measurement numbers chosen by user. Then echo selections into "$middlehalf".txt. This file is embedded inside of scrape.py

# Currently, Selector.sh and all meta-files are in same directory (sub_scripts/), thus dir1=""
dir1="./sub_scripts/"
firsthalf="firsthalfscrapepy.txt"
secondhalf="secondhalfscrapepy.txt"
middlehalf="measforscrapepy.txt"
listofmeas="currentmeaslist.txt"

# Concatenates a single measurement number to "$middlehalf".txt
addSingleToFile() {
	echo -n "MEASUR_NUM=$1" >>"$dir1""$middlehalf"
}

addRangeToFile() {
	echo -n "MEASUR_NUM>=$1 and MEASUR_NUM<=$2" >>"$dir1""$middlehalf"
}

# scrape.py must have this code at line 62 
echo -n 'cmd += " where ' >"$dir1""$middlehalf"
# Clear out file "$listofmeas"
echo -n >"$listofmeas"

# count is the number of times the user adds measurements
count=0

endwhile=1
while [ "$endwhile" -eq 1 ] 
do
	echo "Get data for a SINGLE measurement or a RANGE of measurements?"
	select choice in single range current_list start_over finished 
	do
		case $choice in

		"single") ((count++))
			echo; echo -n "Enter measurement number: "
			read meas
			echo "$meas" >>"$listofmeas"

			if [ "$count" -eq 1 ] 		### If it's the first meas, DO NOT add "and" or "or"
			then
				addSingleToFile "$meas"
			else 
				echo -n " or " >>"$dir1""$middlehalf"
				addSingleToFile "$meas"
			fi
			break ;;

		"range") ((count++))
			echo; echo -n "Enter measurement number at start of range: "
			read beginrange
			echo -n "Enter measurement number at end of range: "
			read endrange
			echo "$beginrange through $endrange" >>"$listofmeas"

			if [ "$count" -eq 1 ] 
			then 
				addRangeToFile "$beginrange" "$endrange"
			else
				echo -n " or " >>"$dir1""$middlehalf"
				addRangeToFile "$beginrange" "$endrange"
			fi
			break ;;

			# Make list of measurements which user can look at.
	"current_list") echo; echo "Current list of measurements: "
			sort -g "$listofmeas"				# Option -g sorts by general numbers.
			break ;;

			# Erase scrape.py code and list of meas. Start over.
	  "start_over")	echo -n 'cmd += " where ' >"$dir1""$middlehalf"	
			echo -n >"$listofmeas"
			count=0
			echo "Measurements deleted."
			break ;;

	    "finished")	(echo -n " \""; echo) >>"$dir1""$middlehalf"	# Finish the middle part of scrape.py
		    	rm "$listofmeas"				# User already has a list of meas.
			endwhile=0
			break ;;

		*) 	echo
			echo "Not a valid option. Choose again." 
			echo
			break ;;	
		esac
	done; echo; 
done

( cat "$dir1""$firsthalf" ; cat "$dir1""$middlehalf" ; cat "$dir1""$secondhalf" ) >"$dir1"scrape.py
