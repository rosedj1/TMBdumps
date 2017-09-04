Welcome, homeboy!

Congratulations. You managed to copy the directory which contains all you need
to begin your ROOT journey.

You want to make a plot with error bars? No problem. I already have the
general framework for you. Open up "EfficiencyPlot.cxx". This is the barebones
code which will read the values in "3colDataFile.txt" and make a plot out of
them.

col1 = x values
col2 = y values
col3 = y errors

Let's try executing it. Make sure you are on your lxplus account. Assuming you
are able to open up ROOT and are using v6 (getting this to work can be quite a 
task), in the Terminal type:

cmsenv 			(This allows you to run the latest version of ROOT)
root			(Opens up ROOT. Hopefully a GUI/little picture will pop up.)
.L EfficiencyPlot.cxx	(Load the C++ code.)
EfficiencyPlot()	(Running the code.)

***Hopefully*** a plot just popped up! If it didn't there can be a variety of
reasons. Google it! For now, let's assume you made the plot.

"Great! But this is your plot, Jake. How do I make my own?"
I'm glad you asked, friend. You can fiddle with just about everything in the
EfficiencyPlot.cxx code. Change the numbers in SetMarkerStyle, SetMarkerSize,
change the name of the TCanvas... do whatever you want! Each time you want to
plot again, be sure to ".L EfficiencyPlot.cxx" and then "EfficiencyPlot()" in
ROOT. 

Also be sure to replace "3colDataFile.txt" with the name of your own
data file. See the "DrawClone" option? Those capital letters (ACEP) all do
different things and I think they are optional. Honestly this is about the
extent of my knowledge with plotting in ROOT. 

If you don't know something feel free to ask, but Google is probably your best
solution. If you learn something cool that you wish to share, I'd be more than
excited to hear about it. I'm very much a beginner in ROOT. 

May you have a successful ROOT journey, AtoZ!

- Jake

P.S. Make sure that the name of your C++ file, the name of the void function
(line 6), and the main function call (line 66) are all exactly the same name.
Otherwise I don't think it will plot. 
