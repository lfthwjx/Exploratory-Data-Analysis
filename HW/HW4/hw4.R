setwd("C:\\UM\\Courses\\SI\\SI618\\HW\\HW4")
cars = read.delim('cars.tsv',stringsAsFactors=FALSE)
#View(cars)
cars.data = cars[,c(3:8)]
rownames(cars.data) = cars$Car
#View(cars.data)
cars.data = scale(cars.data)
head(cars.data,5)

cars.dist = dist(cars.data)
as.matrix(cars.dist)[1:5,1:5]

cars.hclust <- hclust(cars.dist, method = "average")
#View(cars.dist)
plot(cars.hclust,labels=cars$Car,main='Hierarchical cluster analysis using average linkage')
rect.hclust(cars.hclust, k = 3, border = "red")

groups.3 <- cutree(cars.hclust, k=3)
groups.3

table(groups.3)
table(groups.3,cars$Country)
aggregate(cars[,c(3:8)], by = list(groups.3), FUN = median)

library(gplots)
heatmap.2(as.matrix(cars.data), hclustfun = function(x) hclust(x,method = "average"), 
          scale = "column", dendrogram="row", trace="none", density.info="none", 
          col=redblue(256), lhei=c(2,5.0), lwid=c(1.5,2.5), keysize = 0.25, 
          margins = c(5, 8), cexRow=0.7,cexCol=0.7)

library(cluster)
cars.pam = pam(cars.dist,3)
table(groups.3,cars.pam$clustering)

cars$Car[groups.3 != cars.pam$clustering]
cars$Car[cars.pam$id.med]
clusplot(cars.pam, labels=2, main = "k-medoid clustering of cars into 3 groups")

plot(cars.pam)



silo = silhouette(cars.pam,cars.dist)
cars[silo[, "sil_width"]<0,]
