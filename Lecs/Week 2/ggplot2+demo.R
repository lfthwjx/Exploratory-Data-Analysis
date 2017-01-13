library(ggplot2)

#Return to the wine example from the first class
print(getwd())
wine <- read.csv("C:/Users/Sam/Desktop/UMSI/Year 3/SI618/Lecture 2/wine.csv")
str(wine)

#Make R realize that Quality is a category rather than an integer value
wine$Quality <- factor(wine$Quality)
str(wine)

#One important thing to note is that RStudio won't echo the results of R commands by default
#You have to explicitly select "source with echo" from the Source button in the top right
qplot(Hue,Alcohol, data=wine, main="Hue versus alcohol in wines")
readline()
#You can add color as another dimension to a 2d plot

qplot(Hue,Alcohol, data=wine, main="Hue versus alcohol in wines (with color!)", color = Hue)

readline()
#You can also use size as a dimension

qplot(Hue,Alcohol, data=wine, main="Hue versus alcohol in wines (with color (and size!)!)", color = Hue, size = Color.intensity)

readline()
#You can also use shape as a dimension

qplot(Hue,Alcohol, data=wine, main="Hue versus alcohol in wines (with color (and size (and shape!)!)!)", color = Hue, size = Color.intensity,shape = Quality)

readline()
#You can also use transparency as a dimension


qplot(Hue,Alcohol, data=wine, main="Hue versus alcohol in wines (with color (and size (and shape (and transparency!)!)!)!)", color = Hue, size = Color.intensity,shape = Quality, alpha = Magnesium)

readline()
#...things get a little confusing with this much information. This also conflicts with color
# when color is mapped to a continuous variable.


#Categorical variables can make a graph hard to read
qplot(Quality,Alcohol, data=wine, main="Quality vs Alcohol among wines")
readline()

#You can alleviate this by adding some jitter
qplot(Quality,Alcohol, data=wine, main="Quality vs Alcohol among wines (with jitter!)",geom="jitter")

readline()
#You can combine multiple geometries into the same plot

qplot(Quality,Alcohol, data=wine, main="Quality vs Alcohol among wines (with jitter & boxplots!)", geom = c("jitter","boxplot"))

readline()

#You can also create a different plot for each category using facets
wine$alcInOrder  <- wine$Alcohol[order(wine$Alcohol)]
wine$qualInOrder <- wine$Quality[order(wine$Alcohol)]
wine$indices <- rep(1:length(wine$Alcohol))
qplot(indices,alcInOrder, main="Distribution of Alcohol content in wines")
readline()
qplot(indices,alcInOrder, data=wine, facets=.~qualInOrder, main="Distribution of Alcohol content in wines of differing quality")





