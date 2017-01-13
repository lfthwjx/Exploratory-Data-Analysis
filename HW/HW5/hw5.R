setwd("C:\\UM\\Courses\\SI\\SI618\\HW\\HW5")
uscrime<-read.delim('uscrime.txt')
uscrime
View(uscrime)
pcs <- prcomp(uscrime,scale = TRUE)
summary(pcs)
pre <- predict(pcs)
pre
plot(pcs,type = 'l')

biplot(pcs)

plot(uscrime[,c(9,10)])
pearson.cor = cor(uscrime[,c(9,10)],method = "pearson")
pearson.cor

manage<-read.delim('manage.csv',sep = ',')
indx <- sapply(manage,is.factor)
manage[indx] <- lapply(manage[indx],function(x)(factor(as.character(x),levels=c("VERY LITTLE EXTENT","LITTLE EXTENT","SOME EXTENT","MODERATE EXTENT","CONSIDERABLE EXTENT","GREAT EXTENT","TO A VERY GREAT EXTENT"))))
for(i in c(1:11)){
  levels(manage[,i]) <- c(1,2,3,4,5,6,7)
  manage[,i]<-as.numeric(levels(manage[,i])[manage[,i]])
}

factanal(x=manage,factors = 1,rotation = "promax")
factanal(x=manage,factors = 2,rotation = "promax")
factanal(x=manage,factors = 3,rotation = "promax")


