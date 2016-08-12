#import sys and assign arguments as defined in terminal when running VarFreq.sh
import sys
outputdir = sys.argv[1]
PassagesStart = int(sys.argv[2])
PassagesEnd = int(sys.argv[3])
sample=str(sys.argv[4])

data=open(outputdir + sample + '/p' + str(PassagesStart) +'/Q20Freqs_SD.txt', 'r')
length=len(data.readlines())
dataMatrix=[[0 for j in range(4)]for i in range (length)]# creats matrix of 0's that is 4 columns by 'length' rows
data.close()
outfile=open (outputdir + sample +'/Q20FreqsCombined.txt', 'w')
for p in range(PassagesStart,PassagesEnd+1):
	counter=0
	with open(outputdir + sample + '/p' + str(p) +'/Q20Freqs_SD.txt', 'r') as infile:
		next(infile)
		for line in infile:
			columns=line.split()
			NTpos=columns[0]
			refBase=columns[1]
			varBase=columns[2]
			freq=columns[5]
			if p==PassagesStart:
				dataMatrix[counter][0]=NTpos
				dataMatrix[counter][1]=refBase
				dataMatrix[counter][2]=varBase
				dataMatrix[counter][3]=freq
			elif p==PassagesEnd:
				dataMatrix[counter].append(freq)
				#print ('\t'.join(dataMatrix[counter]))
				outfile.write('\t'.join(dataMatrix[counter]))
				outfile.write('\n')
				#outfile.write(dataMatrix[counter][0])
			else:
				dataMatrix[counter].append(freq)
			counter+=1
		infile.close()
outfile.close()
