#!/bin/bash
# SYNTAX: ./PasterAndMover.sh
# PURPOSE: Paste HV_values.txt and efficiency-error file. Then, move all .txt files into new dir.
# Jake R., 2017-07-20

# Paste everything together and sort!
paste HV_values.txt eff_err_values.txt | sort > $Name.txt

# Copy this new file into the ROOT directory to be plotted
cp "$Name".txt ../ROOTfiles/

# Finally move all created .txt files into new dir
echo; mkdir -v "$Name"; echo
mv *.txt "$Name"/

# Copy all tmbs into new dir
cp -R processed_tmb/ filtered_tmb/ tmb/ "$Name"/

# Remove any pre-existing directory of the same name, then move the new dir up one level
rm -fr ../"$Name"
mv -i "$Name"/ ../
