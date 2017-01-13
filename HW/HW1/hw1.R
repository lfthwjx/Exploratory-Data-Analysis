setwd("C:\\UM\\Courses\\SI\\SI618\\HW\\HW1")
#read.table makes errors
#countrydata_withregion<-read.delim("countrydata_withregion.tsv",sep="\t",head=TRUE)
countrydata_withregion<-read.table("countrydata_withregion.tsv",quote = "\"",head=TRUE,sep="\t")
head(countrydata_withregion,15)
plot(log(countrydata_withregion$area),log(countrydata_withregion$population))

area_region<-aggregate(countrydata_withregion$area,by=list(countrydata_withregion$region),FUN=sum)
countrydata_withregion$population<-as.numeric(countrydata_withregion$population)
popu_region<-aggregate(countrydata_withregion$population,by=list(countrydata_withregion$region),FUN=sum)
pie(area_region$x,labels=area_region$Group.1,main = "Area of Regions")
pie(popu_region$x,labels=area_region$Group.1,main = "Population of Regions")

popu_area<-popu_region$x/area_region$x
df_popu_area<-data.frame(popu_region$Group.1,popu_area)
df_ordered<-df_popu_area[order(df_popu_area$popu_area,decreasing = TRUE),]
height_bar=0.4/max(df_ordered$popu_area)*df_ordered$popu_area
barplot(df_ordered$popu_area,names.arg = df_ordered$popu_region.Group.1,xlab = "Population per sq km of Regions",width=c(0.5,0.5,0.5,0.5,0.5,0.5,0.5),cex.names = 0.5,cex.axis = 0.53,cex.lab=0.53)
#?barplot
