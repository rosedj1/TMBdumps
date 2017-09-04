#!/bin/bash
# PURPOSE: Run executables in /Efficiency_studies/ to make a 3-col file to be plotted in ROOT.
# SYNTAX: MasterPlotter.sh CHAMBER (CHAMBER is either "ME11" or "ME21")
# AUTHOR: Jake R., 2017-07-20

chamber="$1"
dir1="sub_scripts/"
#echo "Which chamber are you analyzing?"
#select chamber in ME11 ME21
	
# This var gets exported into PasterAndMover
echo "Name the ROOT data file: "
read Name

echo "Automagicize entire process? (y or n)"
read ans_all
if [ $ans_all = 'y' ] 
then 
	ans_measlist='y'
	ans_scrape='y'
	ans_process='y'
	ans_effdata='y'
else
# If they did not want to perform all actions, give them the choice to list the measurements.
	echo "Create new list of measurements? (y or n)"
	read ans_measlist

# If they did not want to perform all actions, give user the choice to scrape database.
	echo "Scrape data base? (y or n)"
	read ans_scrape

# If they did not want to perform all actions, give them the choice to process TMB dumbs.
	echo "Process the TMB dumps in /tmb/? (y or n)"
	read ans_process

# If they did not want to perform all actions, give them the choice to calculate efficiency.
	echo "Calculate efficiency data? (y or n)"
	read ans_effdata
fi

# Selector.sh lets user select measurements and then creates scrape2.py
if [ "$ans_measlist" = 'y' ]  
then
	./"$dir1"/Selector.sh
fi

# Scraper.sh will scrape the database and put all TMB dumps into /tmb/
# Remember to escape special characters with 3 escape-characters when supplying a PW
if [ "$ans_scrape" = 'y' ]
then
	chmod u+x ./"$dir1"scrape.py
	./"$dir1"scrape.py > ./"$dir1"meta
# In the future, instead of exporting this variable, awk it from meta or from the database or something. MAKE IT AUTOMAGIC
	export chamber
	./"$dir1"downloadtmb.sh ./"$dir1"meta
fi

# HVdata.sh makes HV_values.txt (HV data) and measfile.txt (file that contains the names of all files before processing).

# Filter.sh pulls appropriate chamber number from measfile.txt. 
# Then it separates the mixed ME11 data from ME21 data and makes a new file for each measurement.
# It puts new files in /filtered_tmb/

# Choppa.sh chops up files in filtered_tmb/ and puts all processed files in processed_tmb/.
# Finally, it creates dataforspreadsheet.txt. 
if [ "$ans_process" = 'y' ] 
then 
	./"$dir1"HVdata.sh 
	./"$dir1"Filter.sh
	./"$dir1"Choppa.sh
fi

# EffAndErr.sh creates eff_err_values.txt (file with efficiencies and errors in 2 col.) using processed_m*.txt files
# Paster.sh finishes the job by combining HV_values.txt and eff_err_values.txt while allowing the User to rename the file.
if [ "$ans_effdata" = 'y' ] 
then 
	./"$dir1"EffAndErr.sh
	export Name
	./"$dir1"PasterAndMover.sh
fi

# DONE!!!
echo -ne '\a'; echo -ne '\a'; echo -ne '\a'
