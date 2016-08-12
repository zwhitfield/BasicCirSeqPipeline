options(warn=1)

args = commandArgs(T)
outputdir = args[1]
PassagesStart = as.integer(args[2])
PassagesEnd = as.integer(args[3])
sample= args[4]
# 
# colors=colorRampPalette(c("red","green","blue"))
# palette=colors(length(seq(PassagesStart,PassagesEnd))) #Gives a vector with as many colors as there are passages being analyzed
# colorCounter=1 #Used so that colors of points in the graph match colors in the legend. Probablly a better way to do this
# 
# tiff(paste(outputdir,sample,"/","FragLengthDis.tiff",sep=""),height = 8.5, width = 11, units = 'in', res=300)
# plot (NA, NA, xlim=c(1,99),ylim=c(0,2000000),xlab="Fragment Length", ylab="Number Of Reads", cex.axis=1.25,cex.lab=1.5)
# for (i in PassagesStart:PassagesEnd)
# {
#   data=read.table(paste(outputdir,sample,"/p",i,"/FragmentLengthDistribution.txt",sep=""), header=T)
#   points(data$Length,data$NumberOfReads, cex=1, pch=21, bg=palette[colorCounter])
#   colorCounter=colorCounter+1
# }
# legend ("topleft",legend=paste("p",seq(PassagesStart,PassagesEnd),sep=""), lty=1,lwd=2.5, col=palette, cex=1)
##-------------------------------------------------------------------------------------

png(paste(outputdir,sample,"/","FragLengthDis.png",sep=""),height = 8.5, width = 11, units = 'in', res=300)

par(mfrow=c(length(PassagesStart:PassagesEnd),1))
for (i in PassagesStart:PassagesEnd)
{
  data=read.table(paste(outputdir,sample,"/p",i,"/FragmentLengthDistribution.txt",sep=""), header=T)
  plot (NA, NA, xlim=c(1,99),ylim=c(0,max(data$NumberOfReads)),xlab="Fragment Length", ylab="Number Of Reads", cex.axis=1.25,cex.lab=1.5, main=paste(sample,"passage",i,sep=""))
  points(data$Length,data$NumberOfReads, cex=0.5,pch=21, col="BLACK",bg="BLACK")
}