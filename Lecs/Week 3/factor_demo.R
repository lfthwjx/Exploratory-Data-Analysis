#Same old wine dataset
wine <- read.csv("C:/Users/Sam/Desktop/UMSI/Year 3/SI618/Lecture 2/wine.csv")
str(wine)
readline()

#You can convert a data frame to factors with the as.factors() command
wine$Quality <- factor(wine$Quality)
str(wine)
print(levels(wine$Quality))
readline()

#qplot will automatically allocate one bucket per factor
qplot(Quality, data=wine, geom="histogram")
readline()

#what if we wanted the buckets to be displayed in a different order?

#Here, I reorder the Quality category order to be the reverse of the natural order when it
#is interpreted as a number
qplot(reorder(Quality,-as.numeric(Quality)), data=wine, geom="histogram")

