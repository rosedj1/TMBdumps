#!/bin/bash
# SYNTAX: ./EffAndErr.sh
# PURPOSE: Calculate the average efficiency and standard deviation of a measurement and make a 2-col file of the values. 
# Jake R., 2017_07_19

list=$( ls ./processed_tmb/ )

echo -n >eff_err_values.txt

for file in $list
do
	# Calculate individual efficiencies for each spill set, sum them, and divide by the number of efficiencies to get avgeff.
	# Calculate standard deviation of avgeff, according to Dr. Korytov's sigma=sqrt(avgeff*(1-avgeff)/n), where n = total triggers, I guess...
	awk '{L1ATMB=$31; L1A=$30; 
		if ((L1A + 0) != 0) 
			{eff=(L1ATMB/L1A); sum+=eff; sumL1A+=L1A; count++;} 
		else next
		}; 

		END{
			avgL1A=(sumL1A/count); 
			avgeff=(sum/count); 
			stdev=sqrt(avgeff*(1-avgeff)/avgL1A); 
			printf "%.9f\t%.9f\n",avgeff,stdev
		}' ./processed_tmb/$file >> ./eff_err_values.txt
done
