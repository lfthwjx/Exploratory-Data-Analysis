library(DBI)
library(RSQLite)
library(ggplot2)
library(plyr)
setwd("C:\\UM\\Courses\\SI\\SI618\\HW\\HW3")

sqlite    <- dbDriver("SQLite")
conn <- dbConnect(sqlite,"vehicles.db")
query_result<-dbSendQuery(conn,"SELECT * FROM vehicles")
vehicles<-dbFetch(query_result,n=-1)
dbClearResult(query_result)
#vehicles<-na.omit(vehicles)
#str(vehicles)
vehicles$cylinders<-as.numeric(vehicles$cylinders)
vehicles$displ<-as.numeric(vehicles$displ)
vehicles<-vehicles[!is.na(vehicles$cylinders),]
head(vehicles,10)
#tail(vehicles)
summary(vehicles)

vehicles$make<-as.factor(vehicles$make)
vehicles$VClass<-as.factor(vehicles$VClass)
vehicles$cylinders<-as.factor(vehicles$cylinders)
vehicles$trany<-as.factor(vehicles$trany)
summary(vehicles)

#sub_vehicles<-cbind(vehicles$make,vehicles$VClass,vehicles$year)
sub_vehicles<-ddply(vehicles,c('make','VClass'),function(vehicles)(count(vehicles$year)))
count_vehicles<-ddply(sub_vehicles,c('make','VClass'),function(sub_vehicles)length(sub_vehicles$x))
colnames(count_vehicles)<-c('make','VClass','year_count')
filtered<-count_vehicles[count_vehicles$year_count>=20,]
filtered

merged<-merge(filtered,vehicles,by=c('make','VClass'))
summary(merged)

mains<-unique(merged$VClass)
vclass<-as.character(factor(mains))
for(i in 1:length(vclass)){
  vc_vehicles<-merged[merged$VClass==vclass[i],]
  sub_vc<-ddply(vc_vehicles,c('year','make'),function(vc_vehicles)(mean(vc_vehicles$comb08)))
  p<-ggplot(data=sub_vc,aes(x=year,y=V1,color=make))+theme_set(theme_grey(base_size = 18))+ggtitle(vclass[i])+theme(plot.title = element_text(hjust = 0.5))
  p<-p+geom_point()+xlab("Year")+ylab("Mean Combined MPG")+geom_smooth(se=FALSE)
  print(p)
  sub_mk<-ddply(vc_vehicles,c('make'),function(vc_vehicles)mean(vc_vehicles$comb08))
  q<-ggplot(data = sub_mk,aes(reorder(make,V1),V1))+ theme(axis.text.x = element_text(angle = 90, hjust = 1),plot.title = element_text(hjust = 0.5))
  q<-q+geom_bar(stat = "identity")+labs(title=vclass[i],x="Make",y="Mean Combined MPG in All Years")
  print(q)
}
