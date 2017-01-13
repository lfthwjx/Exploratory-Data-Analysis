library(ggplot2)
?iris
str(iris)
p = ggplot(iris,aes(Sepal.Length,Sepal.Width,colour=factor(Species)))
p + layer(geom="point",stat = "identity",position = "identity") + geom_smooth()
