#Calculates frequency of all possible nucleotides at each nucleotide position. Prints a line for every potential variant base (including the reference itself) whether or not the variant itself was actually detected.

#import sys and assign arguments as defined in terminal when running VarFreq.sh
import sys
outputdir = sys.argv[1]
PassagesStart = int(sys.argv[2])
PassagesEnd = int(sys.argv[3])
sample=str(sys.argv[4])
genomeLength=int(sys.argv[5])

#create output file with headers 'Pos','RefBase','VarBase', 'Counts','TotalCounts','Freq', 'StdDev'
#Standard Deviation is calculated by sd=sqrt(coverage*freq*(1-freq))/coverage
for p in range(PassagesStart,PassagesEnd+1):
	outfile=open (outputdir + sample + '/p' + str(p) +'/Q20Freqs_SD.txt', 'w')
	outfile.write('%s\t%s\t%s\t%s\t%s\t%s\t%s\n' % ('Pos','RefBase','VarBase', 'Counts','TotalCounts','Freq', 'StdDev'))
	with open(outputdir + sample + '/p' + str(p) +'/Q20threshold.txt', 'r') as infile:
		for line in infile:
			columns=line.split()
			NTpos=columns[0]
			referencebase=(columns[1])
			baseA= float(columns[2])
			baseC= float(columns[3])
			baseG= float(columns[4])
			baseT= float(columns[5])
			totalCount=baseA+baseC+baseG+baseT
			for base in range(2,6):
				if base==2:
					varBase='A'
				if base==3:
					varBase='C'
				if base==4:
					varBase='G'
				if base==5:
					varBase='T'
				count=float(columns[base])
				if totalCount==0:
					freq=count/1
					sd=0.0
				else:
					freq=count/totalCount
					sd=((totalCount*freq*(1-freq))**0.5)/totalCount
				outfile.write('%s\t%s\t%s\t%s\t%s\t%s\t%s\n' % (NTpos,referencebase,varBase,count,totalCount,freq,sd))
