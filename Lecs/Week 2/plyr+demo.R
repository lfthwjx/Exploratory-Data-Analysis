#Set the random seed
set.seed(1)


#A script constitutes a different execution environment than your console: you have
#to call libary to get access to the package, even if your console already knows 
#about it
library (plyr)
library(ggplot2)


#Create a simple data frame where each row is a year and a random count from 0-20
d <- data.frame(year = rep(2000:2002, each = 3), count = round(runif(9,0,20)))
print(d)
readline()



#the standard 'print' function won't print newlines. Use 'cat' instead
cat("\n##############################################\n")
cat("plied")
#Simple use of ddply to group the frame by year, then figure out the coefficient of
#variation for the counts of each year
plied <- ddply(d, "year", function(x) {
  mean <- mean(x$count)
  sd <- sd(x$count)
  cv <- sd/mean
  return(data.frame(cv = cv))
})

print(plied)
readline()
cat("\n##############################################\n")
cat("summarised")
#Throw in a call to the summarise function to generate a condensed new frame
summed <- ddply(d, "year", summarise, mean = mean(count))
print(summed)
readline()
cat("\n##############################################\n")
cat("transformed")

#Use transform to perform the operations specified, but return the uncondensed 
#frame

transformed <- ddply(d, "year", transform, mean = mean(count))
print(transformed)
readline()
cat("\n##############################################\n")
cat("d_ply used to plot")
#You can think of **ply functions as a way to replace loops by telling R to run some
#function on every grouped row. 

#For example, you can throw away the output with d_ply, and then use it to plot the data



#Group d by year, then for each year, plot count
d_ply(d, "year", transform, qplot(year,count, data=d))


cat("\n##############################################\n")







