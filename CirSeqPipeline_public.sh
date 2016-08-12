#!/bin/bash

#TOPDIR=$1 #/home/zwhitfield/Desktop/CirSeqTest
#SCRIPTDIR=$2 #/home/zwhitfield/Desktop/CirSeqFiles/Scripts/BasicCirSeqPipeline

printf "\n"

printf "Please enter the TOPDIRECTORY (see ReadMe):"
read TOPDIR

printf "Please enter the SCRIPTDIRECTORY (see ReadMe):"
read SCRIPTDIR

printf "Please enter the starting passage to be analyzed(integer):"
read PASSAGESTART

printf "Please enter the ending passage to be analyzed(integer):"
read PASSAGEEND

printf "Please enter the genome length of the virus being analyzed (# of nucleotides; integer):"
read GENOMELENGTH

printf "Please enter the sample to be analyzed (should be a string, such as WT. No spaces!):"
read SAMPLE

printf "Please enter the FIRST nucleotide position that is coding for the viral genome of interest (integer):"
read CODINGSTARTPOSITION

printf "Please enter the LAST nucleotide position that is coding for the viral genome of interest (integer):"
read CODINGENDPOSITION

OUTPUTDIR=${TOPDIR}/"CirSeq"

printf "\n"

printf "Graphing fragment distribution..."
#Graph the distribution of repeat lengths.
#Removed instances of using attach()
Rscript ${SCRIPTDIR}/GraphFragmentLengthDistribution_bash.R ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE
printf "Done"
printf "\n"

printf "Calculating average coverage..."
#Outputs frequecny variants from Q[score]threshold.txt file
python ${SCRIPTDIR}/AverageCoverage_bash.py ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE $GENOMELENGTH
printf "Done"
printf "\n"

printf "Calculating variant frequencies..."
#Outputs frequecny variants from Q[score]threshold.txt file
python ${SCRIPTDIR}/IdentifyVariantFrequency_bash_v2.py ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE $GENOMELENGTH
printf "Done"
printf "\n"

printf "Pooling variant frequencies by passage..."
#Pools together frequencies for all passages for every possible nucleotide at every possible position into one file. Freads .
python ${SCRIPTDIR}/CombineQ20FreqsByPassage_bash.py ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE
printf "Done"
printf "\n"
