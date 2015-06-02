# BasicCirSeqPipeline
Running CirSeqPipeline.sh

Need to set up two directories:

SCRIPTDIRECTORY: A single folder containing all of the necessary scripts.

	CirSeqPipeline.sh
	GraphFragmentLengthDistribution_bash.R
	IdentifyVariantFrequency_bash_v2.py
	CombineQ20FreqsByPassage_bash.py
	TranslateQ20_bash_v2.py
	MaximumLikelihoodEstimation_Q20_Zach.R
	VariantByGenPos_bash.R
	FitnessODR_bash_v2.py
	GraphFitnessODR_bash.R

----------------------------------------------------------------------------------------------------------------------------------
TOPDIRECTORY: Location of directory that leads to Q20threshold.txt and FragmenLengthDistribution.txt files. See below.

	Data MUST be organized in the following way:
		[TOPDIRECTORY]/CirSeq[SAMPLENAME]/p[PassageNumber]/Q20threshold.txt

	Example:

	/home/zwhitfield/Desktop/CirSeqFiles/Data/CirSeqM/p3/Q20threshold.txt
	/home/zwhitfield/Desktop/CirSeqFiles/Data/CirSeqM/p3/FragmenLengthDistribution.txt

	/home/zwhitfield/Desktop/CirSeqFiles/Data/CirSeqM/p4/Q20threshold.txt
	/home/zwhitfield/Desktop/CirSeqFiles/Data/CirSeqM/p4/FragmenLengthDistribution.txt

	/home/zwhitfield/Desktop/CirSeqFiles/Data/CirSeqM/p5/Q20threshold.txt
	/home/zwhitfield/Desktop/CirSeqFiles/Data/CirSeqM/p5/FragmenLengthDistribution.txt

	/home/zwhitfield/Desktop/CirSeqFiles/Data/CirSeqM/p6/Q20threshold.txt
	/home/zwhitfield/Desktop/CirSeqFiles/Data/CirSeqM/p6/FragmenLengthDistribution.txt

		TOPDIRECTORY= /home/zwhitfield/Desktop/CirSeqFiles/Data
			DO NOT end TOPDIRECTORY with a forward slash (/)
			Folder directly after TOPDIRECTORY must be /CirSeq[SAMPLENAME]/p[passageNumber]/Q20threshold.txt
		SAMPLENAME= M
		Passages being analyzed MUST be sequential (3,4,5,6; not 3,5,7)
---------------------------------
	For poliovirus (Mahoney) with the above example:
		"Please enter your TOPDIRECTORY (see ReadMe for instructions):"
			/home/zwhitfield/Desktop/CirSeqFiles/Data

		"Please enter your SCRIPTDIRECTORY (see ReadMe for instructions):"
			/home/zwhitfield/Desktop/CirSeqFiles/Scripts/BasicCirSeqPipeline

		"Please enter the starting passage to be analyzed(integer):"
			3

		"Please enter the ending passage to be analyzed(integer):"
			6

		"Please enter the genome length of the virus being analyzed:"
			7440

		"Please enter the sample to be analyzed (should be a string, such as WT. No spaces!):"
			M

		"Please enter the FIRST nucleotide position that is coding for the viral genome of interest (integer):"
			746

		"Please enter the LAST nucleotide position that is coding for the viral genome of interest (integer):"
			7372
---------------------------------
