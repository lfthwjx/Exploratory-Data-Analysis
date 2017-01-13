library(DBI) 
library(RSQLite)
library(ggplot2)
dbdriver = dbDriver("SQLite")
connect = dbConnect(dbdriver, dbname = "C:/Users/Sam/Desktop/UMSI/Year 3/SI618/Lecture 3/carsDatabase.db")
vehicles = dbGetQuery(connect, "select * from Cars")
vehicles

ggplot(vehicles)+geom_point(aes(x=Id, y=Price))