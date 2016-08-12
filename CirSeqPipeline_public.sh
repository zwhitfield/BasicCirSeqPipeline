#!/bin/bash

TOPDIR=$1 #/home/zwhitfield/Desktop/CirSeqTest
SCRIPTDIR=$2 #/home/zwhitfield/Desktop/CirSeqFiles/Scripts/BasicCirSeqPipeline

printf "\n"

#printf "Please enter the TOPDIRECTORY (see ReadMe):"
#read TOPDIR

#printf "Please enter the SCRIPTDIRECTORY (see ReadMe):"
#read SCRIPTDIR

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

printf "Translating Q20threshold.txt..."
#Translate the Q20threshold.txt file
python ${SCRIPTDIR}/TranslateQ20_bash_v2.py ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE $CODINGSTARTPOSITION $CODINGENDPOSITION
printf "Done"
printf "\n"

#printf "Translating Q20threshold.txt..."
#Translate the Q20threshold.txt file
#python ${SCRIPTDIR}/TranslateEbola_pandas.py ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE $CODINGSTARTPOSITION $CODINGENDPOSITION
#printf "Done"
#printf "\n"

#printf "Translating Q20threshold.txt... GP Only"
#Translate the Q20threshold.txt file using GP reading frames in Ebola
#python ${SCRIPTDIR}/TranslateEbola_GP_pandas.py ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE $CODINGSTARTPOSITION $CODINGENDPOSITION
#printf "Done"
#printf "\n"

printf "Calculating mutation frequency (this may take awhile)..."
printf "\n"
printf "Current passage number being analyzed:"
printf "\n"
#Calculate mutation frequency using Ashley's MLE script.
#REMEMBER TO CHANGE REQUIRED INITIAL COVERAGE TO 100,000 (LINE 67 AND 68) FOR GOOD CIRSEQ DATA
Rscript ${SCRIPTDIR}/MaximumLikelihoodEstimation_Q20_Zach.R ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE
printf "Done"
printf "\n"

printf "Graphing variants..."
printf "\n"
printf "Current Passage Number:"
printf "\n"
#Graph variants that pass binomial test (frequency significantly above mutation rate)
#Removed instances of using attach()
Rscript ${SCRIPTDIR}/VariantByGenPos_bash.R ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $GENOMELENGTH $SAMPLE
printf "Done"
printf "\n"

printf "Calculating fitness (ODR method)..."
printf "\n"
printf "Current Passage Number:"
printf "\n"
#Reports on variant fitness based on Ashley's OrthogonalRegression.py script.
python ${SCRIPTDIR}/FitnessODR_bash_WithFilters.py ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE $GENOMELENGTH
printf "Done"
printf "\n"

#printf "Calculating fitness GP only (ODR method)..."
#printf "\n"
#printf "Current Passage Number:"
#printf "\n"
#Reports on variant fitness based on Ashley's OrthogonalRegression.py script.
#python ${SCRIPTDIR}/FitnessODR_bash_WithFilters_EBOVGPonly.py ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE $GENOMELENGTH
#printf "Done"
#printf "\n"

printf "Generating fitness plots..."
#Graph fitness of variant along the genome.
Rscript ${SCRIPTDIR}/GraphFitnessODR_bash_v4.R ${OUTPUTDIR} $SAMPLE $GENOMELENGTH
printf "Done"
printf "\n"

#printf "Plotting frequency animations..."
#Animate frequencies over passage based on Rsquared threshold
#Rscript ${SCRIPTDIR}/GraphVariantFreqbyFitness_bash_ggPlot.R ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $SAMPLE $GENOMELENGTH
#printf "Done"
#printf "\n"

#printf "Plotting coverage only..."
#Plot only coverage, independent of variant frequencies
#Rscript ${SCRIPTDIR}/GraphCoverageOnly.R ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $GENOMELENGTH $SAMPLE
#printf "Done"
#printf "\n"

#printf "Plotting ALL variant frequencies..."
#Plots all frequecny variants from Q20Freqs_SD.txt file
#Rscript ${SCRIPTDIR}/GraphAllVariants.R ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $GENOMELENGTH $SAMPLE
#printf "Done"
#printf "\n"

#printf "Plotting filtered variant frequencies..."
#Plots all frequecny variants from Q20Freqs_SD.txt file
#Rscript ${SCRIPTDIR}/GraphAllVariants_CoverageFiltered.R ${OUTPUTDIR} $PASSAGESTART $PASSAGEEND $GENOMELENGTH $SAMPLE
#printf "Done"
#printf "\n"

