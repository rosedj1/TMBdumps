#!/usr/bin/python
'''
Created on 2 Jun 2017

@author: kkuzn
'''
import sys

def getIforFromOneDump(aDump):
    values = []
    x = [0,1,9,10, 38,39,41,44,64,65,66]
    for i in range(0,10):
        tmp = aDump[x[i]][:-1]
        if(i<2):
            values.append(tmp.split(": ")[1].lstrip())
        else:
            values.append(tmp.split(" ")[-1])
            #print values[i].split(" ")[-1]
                     
    return values

if __name__ == '__main__':
    if (len(sys.argv)<2):
        print "usage :\n", sys.argv[0], " filename\n \tor \n", sys.argv[0], " h ",
        exit()
    if(sys.argv[1]=='h'):
        print "0ALCT: alct0 valid pattern flag received"
        print "1ALCT: alct1 valid pattern flag received "
        print "29CLCT: clct0 sent to TMB matching section "     
        print "30CLCT: clct1 sent to TMB matching section  "    
        print "32TMB:  TMB clct*alct matched trigger        "   
        print "35TMB:  TMB match reject event                "  
        print "55L1A:  L1A received                           " 
        print "56L1A:  L1A received, TMB in L1A window         "
        print "filename like /home/kkuzn/CSC/lxplus/Efficiency2017/TMB/m3816_ME21_HV0_test40_SRCoff_170513_003625_TMBCounters.txt"
        exit()
    
    fname   = sys.argv[1]
    outname = fname.replace("Counters.txt", "INFO.out")
    print " input file name : ", fname
    print "output file name : ", outname
    try:
        #/home/kkuzn/CSC/lxplus/Efficiency2017/TMB/m3816_ME21_HV0_test40_SRCoff_170513_003625_TMBCounters.txt'
        with open(fname) as f:    
            lines = f.readlines()
    except:
        print "can't open file ", fname
        exit()
    titles = ["time", "period", "0ALCT", "1ALCT", "29CLCT", "30CLCT", "32TMB", "35TMB", "55L1A", "56L1A"]
    NLines = len(lines)
    if(NLines<2):
        print "empty file?"
        exit
    i=1
    nDumps = 0
    values = []
    while (i<NLines-1):
        oneDump = []
        proceed = True
        while(proceed):
            oneDump.append(lines[i])
            proceed = ((i<NLines-1) and (lines[i][0:4])!='####')
            i+=1
        nDumps+=1
        values.append(getIforFromOneDump(oneDump))
    formats = ["%25s", "%10s", "%10s", "%10s", "%10s", "%10s", "%10s", "%10s", "%10s", "%10s"]
    for i in range (0,len(titles)):
        print formats[i]%titles[i],
    print ""
    
    outfile = open(outname,"w")    
    for aline in values:
        strout = ""
        for i in range (0,len(aline)):
            print formats[i]%aline[i],
            strout+=formats[i]%aline[i]
        print ""
        strout+="\n"
        outfile.write(strout)
    outfile.close()
