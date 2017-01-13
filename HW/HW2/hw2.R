library(ggplot2)
library(plyr)
setwd("C:\\UM\\Courses\\SI\\SI618\\HW\\HW2")
businessdata<-read.table("businessdata.tsv",sep = '\t',head=TRUE,quote = "",comment.char = "")
businessdata<-na.omit(businessdata)
#summary(businessdata_desired_output_first10k)
# dim(businessdata_desired_output_first10k)
head(businessdata,15)
#View(businessdata_desired_output_first10k)
#str(businessdata_desired_output_first10k)
#a little error remaining, decimal fraction left for the xlab
qplot(x=stars,facets = .~state,fill=state,main = "Histograms of Star Ratings",binwidth=0.5,data=businessdata)
qplot(x=review_count,main="Histograms of Review Counts",xlab="Review Counts",data = businessdata)
qplot(x=log(review_count),main="Histograms of Review Counts",xlab="log(Review Counts)",data = businessdata)

subset_bus = subset(businessdata,review_count<=100&review_count>=0,review_count)
#View(subset_bus)
#qplot(review_count,data=subset_bus ,main = "Histograms of Review Counts (Filtered)",xlab="Review Counts",geom=c("histogram","density"))
#qplot(x=subset_bus$review_count,main = "Histograms of Review Counts (Filtered)",xlab="Review Counts",binwidth=2)+geom_density(aes(y=..density..))
qplot(x=subset_bus$review_count,main = "Histograms of Review Counts (Filtered)",xlab="Review Counts",geom="density")+
  geom_histogram(aes(y=(..count..)/(2*sum(..count..))),center=0.99,binwidth = 2,alpha=0.5)

#qplot(x=subset_bus$review_count,main = "Histograms of Review Counts (Filtered)",xlab="Review Counts",geom="density")

qplot(state, stars, data = businessdata, geom = "boxplot", colour = state, fill = state, alpha = 0.5, main = "Star Ratings by States")+scale_alpha(guide = 'none')
qplot(state, stars, data = businessdata, geom = "jitter", colour = state, fill = state, alpha = 0.5, main = "Star Ratings By States") + scale_alpha(guide = 'none')
qplot(state, data = businessdata)
qplot(x=stars,y=review_count,data = businessdata,fill=state,color=state)

#test_bus<-businessdata[1:100,]
#head(test_bus)
ddply_bus<-ddply(businessdata,c("city","main_category"),transform,rank=rank(-stars,ties.method = "first"))
head(ddply_bus,20)

thai_bus<-subset(businessdata,main_category=="Thai")
ddply_thai<-ddply(thai_bus,.(city),transform,rank=rank(-stars,ties.method = "first"))
#head(ddply_thai)
thai_top5_all = subset(ddply_thai,rank<=5)
#head(thai_top5_all)
thai_top5 = subset(ddply_thai[,c(2,1,7)], rank <= 5)
thai_top5<-arrange(thai_top5,city,rank)
#head(thai_top5,20)
thai_top5

mean_stars = ddply(thai_top5_all,.(state),summarise,mean_star=mean(stars),mean_review=mean(review_count))
qplot(reorder(state,mean_star,function(x)-x),mean_star,data=mean_stars,geom = "point",ylab = "Mean Star Rating",xlab = "State",size=mean_review,main = "Mean Star Rating of Top Thai Restaurants, by State")

