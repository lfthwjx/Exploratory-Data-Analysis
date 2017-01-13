library(ggplot2)
#Same old wine dataset
wine <- read.csv("C:/Users/Sam/Desktop/UMSI/Year 3/SI618/Lecture 2/wine.csv")
str(wine)
readline()

#We can construct plots layer by layer

#Here we do an empty plot, and add a scatter plot layer
ggplot(wine)+geom_point(aes(x=Alcohol,y=Color.intensity))+ggtitle("Scatterplot method 1")
readline()

#We can do the same thing a different way
ggplot(wine,aes(x=Alcohol,y=Color.intensity))+ geom_point() +ggtitle("Scatterplot method 2")
readline()

#Index of aesthetics available at:
# http://docs.ggplot2.org/current/index.html

#We can create a histogram by attaching a geom_histogram layer
#to an empty plot
ggplot(wine) + geom_histogram(aes(x=Alcohol), binwidth=0.1) + ggtitle("Histogram")
readline()

#We can add a density curve (and have it be on the right scale)
#by setting the histogram y value equal to the "..density.." keyword and then attaching a geom_density() object
ggplot(wine, aes(x=Alcohol)) + geom_histogram(aes(y = ..density..), binwidth=0.1) +geom_density()+ggtitle("Histogram with density curve")
readline()

#Other useful layers include stat_smooth()
ggplot(wine,aes(x=Alcohol,y=Color.intensity))+ geom_point() +stat_smooth() +ggtitle("Scatterplot method with smooth line")
readline()

#Facets are pretty easy too

ggplot(wine,aes(x=Alcohol,y=Color.intensity))+geom_point() +stat_smooth() +ggtitle("Scatterplots with smoothing by wine quality")+ facet_grid(.~Quality)
readline()






