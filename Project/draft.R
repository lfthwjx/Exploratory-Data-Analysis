#library(Rlinkedin)
#in.auth <- inOAuth()
#my.connections <- getMyConnections(in.auth)
#facebook <- getCompany(token = in.auth,universal_name = "Facebook")

#noaakey <- ZfuSxbJXOnCAAtVtMRsPnukfZissLbgu

#Sys.getenv("noaakey")

library(countyweather)
library(rnoaa)
library(dplyr)
library(lubridate)
#install.packages("hydroTSM")
library(hydroTSM)
library(xts)
#setwd("C:\\UM\\Courses\\SI\\SI618\\Project")
Sys.setenv(LANGUAGE="en")
Sys.setlocale("LC_ALL", "English")
options("noaakey" = Sys.getenv("noaakey"))

library(ggplot2)
ggplot(andrew_precip$daily_data, aes(x = date, y = prcp, color = prcp_reporting)) + 
  geom_line() + geom_point() + theme_minimal() + 
  xlab("Date in 2015") + ylab("Daily rainfall (mm)") + 
  scale_color_continuous(name = "# stations\nreporting")

?daily_fips

newyork_winter_2015 <- daily_fips(fips = "36061", date_min = "2015-12-01", date_max = "2016-03-31", var = c("prcp","tmin","tmax","snow","snwd"))
newyork_winter_2014 <- daily_fips(fips = "36061", date_min = "2014-12-01", date_max = "2015-03-31", var = c("prcp","tmin","tmax","snow","snwd"))
newyork_winter_2013 <- daily_fips(fips = "36061", date_min = "2013-12-01", date_max = "2014-03-31", var = c("prcp","tmin","tmax","snow","snwd"))
newyork_winter_2015

df_proc <- function(newyork_winter_2015){
  df_winter_2015 <- newyork_winter_2015$daily_data[,c(1:6)]
  #str(df_winter_2015)
  df_winter_2015 <- cbind(df_winter_2015,rowMeans(df_winter_2015[,c(5:6)]))
  colnames(df_winter_2015)[7]<-"mean temp"
  df_winter_2015
}
df_winter_2015 <- df_proc(newyork_winter_2015)
df_winter_2014 <- df_proc(newyork_winter_2014)
df_winter_2013 <- df_proc(newyork_winter_2013)

ggplot(df_winter_2015,aes(x=date,y=snow),main="Snowfall in 2015 winter")+geom_line()+geom_point()+theme_minimal()+xlab("Date in 2015 Winter") + ylab("Daily snowfall (mm)")
ggplot(df_winter_2015,aes(x=date,y=prcp),main="precipitation in 2015 winter")+geom_line()+geom_point()+theme_minimal()+xlab("Date in 2015 Winter") + ylab("Daily rainfall (mm)")

ggplot(df_winter_2015,aes(x=date,y=snow))+ggtitle("Snowfall in 2013, 2014 and 2015 winter")+geom_line()+geom_line(data=df_winter_2014)+geom_line(data=df_winter_2013)+theme_minimal()+xlab("Date in Winter") + ylab("Daily snowfall (mm)")

mean_temp<-data.frame(c("2013","2014","2015"),c(mean(df_winter_2013$`mean temp`),mean(df_winter_2014$`mean temp`),mean(df_winter_2015$`mean temp`)))
colnames(mean_temp) <- c("Years","mean temperature in winter")

mean_prcp<-data.frame(c("2013","2014","2015"),c(mean(df_winter_2013$prcp),mean(df_winter_2014$prcp),mean(df_winter_2015$prcp)))
colnames(mean_prcp) <- c("Years","mean precipitation in winter")

newyork_sandy <- daily_fips(fips = "36061", date_min="2012-10-28",date_max = "2012-11-02",var = c("prcp","awnd"))
newyork_irene <- daily_fips(fips = "36061", date_min="2011-08-26",date_max = "2011-08-31",var = c("prcp","awnd"))
newyork_hour_2012<-hourly_fips(fips = "36061", year = 2012, var = c("wind_speed","temperature"))
newyork_hour_2011<-hourly_fips(fips = "36061", year = 2011, var = c("wind_speed","temperature"))

newyork_sandy$daily_data
newyork_irene$daily_data

to_plot <- newyork_hour$hourly_data %>%
  filter(months(date_time) == "October")

ggplot(to_plot, aes(x = date_time, y = wind_speed,
                    color = wind_speed_reporting)) + 
  geom_line() + theme_minimal() + 
  xlab("Date in October 2012") + 
  ylab("Wind speed (m/s)") + 
  scale_color_continuous(name = "# stations\nreporting")
ggplot(to_plot, aes(x = date_time, y = temperature,
                    color = temperature_reporting)) + 
  geom_line() + theme_minimal() + 
  xlab("Date in October 2012") + 
  ylab("Temperature (degrees Celsius)") + 
  scale_color_continuous(name = "# stations\nreporting")

newyork_2015 <- daily_fips(fips = "36061", date_min = "2015-01-01", date_max = "2015-12-31", var = c("prcp","tmin","tmax"))

year_proc<-function(newyork_2015){
  ny_year_2015 <- newyork_2015$daily_data[,c(1:4)]
  ny_year_2015 <- cbind(ny_year_2015,rowMeans(ny_year_2015[,3:4]))
  colnames(ny_year_2015)[5] <- "mean_temp"
  ny_year_2015
}

ny_year_2015 <- year_proc(newyork_2015)
ny_s_2015 <- ny_year_2015[,c(1,2,5)]
ts_ny_2015<-read.zoo(ny_s_2015)
x <- window(ts_ny_2015, start=as.Date("2015-01-01"))
daily2monthly(x[,1], FUN=sum)
daily2monthly(x[,2], FUN=mean)
smry(x)
hydroplot(x[,1], var.type="Precipitation", main="at New York City", pfreq = "dm", from="2015-01-01")

ggplot(ny_year_2015,aes(x=date,y=prcp),main="Precipitation in 2015")+geom_line()+geom_point()+theme_minimal()+xlab("Date in 2015") + ylab("Daily rainfall (mm)")

ggplot(ny_year_2015,aes(x=date,y=mean_temp),main="Averaged temperature in 2015")+geom_line()+geom_point()+theme_minimal()+xlab("Date in 2015") + ylab("Temperature (degrees Celsius)") + geom_smooth(span=0.3)


orange_2015<-daily_fips(fips = "36071",date_min = "2015-01-01", date_max = "2015-12-31", var = c("prcp","tmin","tmax"))
or_year_2015 <- year_proc(orange_2015)

ny_2015<-data.frame(c("Averaged temperature","Averaged precipitation"),c(mean(ny_year_2015$mean_temp),mean(ny_year_2015$prcp)))
colnames(ny_2015)<-c("Year","Amount")
or_2015<-data.frame(c("Averaged temperature","Averaged precipitation"),c(mean(or_year_2015$mean_temp),mean(or_year_2015$prcp)))
colnames(or_2015)<-c("Year","Amount")
