import sys
outputdir =  sys.argv[1] #'/home/zwhitfield/Desktop/CirSeqTest/CirSeq'
PassagesStart = int(sys.argv[2])
PassagesEnd = int(sys.argv[3])
sample= str(sys.argv[4])
genomeLength= int(sys.argv[5])

outfile=open(outputdir + sample +'/AverageCoverage.txt', 'w')
outfile.write("Sample" + '\t' + "PassageNumber" + '\t' + "AverageCoverage" + '\n')

for p in range(PassagesStart,PassagesEnd+1):
	totalReads=0
	with open(outputdir + sample + '/p' + str(p) +'/Q20threshold.txt', 'r') as infile:
		for line in infile:
			columns=line.split()
			totalReads=totalReads + float(columns[2]) + float(columns[3]) + float(columns[4]) + float(columns[5])
		outfile.write(sample + '\t' + str(p) + '\t' + str(totalReads/genomeLength) + '\n')
		infile.close()
