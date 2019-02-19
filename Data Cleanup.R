## Christin Selle
## Spatial Data Analysis and Management
## Lab 5 


# Libraries ---------------------------------------------------------------

library(plyr)
library(stringr)
library(pastecs)
library(oce)
library(lubridate)
library(devtools)
library(dplyr)
library(readxl)

a = read_excel(path = "Alaska.xlsx", col_names = T)
a = as.data.frame(a)
a = rename(a, jellyfish = names(a[8]))
a$Year = NULL

a$date <- with(a, sprintf("%02d/%d", month, year))

a1 = a[,c("date", "long", "lat")]
# Peru --------------------------------------------------------------------

p = read_excel(path = "Peru.xlsx", col_names = T)
p = as.data.frame(p)
n = names(p)
n = tolower(n)
names(p) = n

#Date Format
#need to change to date data type for R if you don't want it to be character
p$date = with(p, sprintf("%02d/%d", month, year))

#Convert to decimal degrees---------
t  = str_sub(p$long, start = -1)
t1 = str_split_fixed(p$long, pattern = "W", n = 3) #removes W
t2 = str_split_fixed(string = t1[,1], pattern = "°", n = 2) #split degrees and miutes
lon = (as.numeric(t2[,2])/60) + as.numeric(t2[,1]) * -1


r  = str_sub(p$lat, start = -1)
r1 = str_split_fixed(p$lat, pattern = "S", n = 3) #removes W
r2 = str_split_fixed(string = r1[,1], pattern = "°", n = 2) #split degrees and miutes
lat = (as.numeric(r2[,2])/60) + as.numeric(r2[,1]) * -1

p$long = lon
p$lat = lat

p1 = p[,c("date", "long", "lat")]

# GOM ---------------------------------------------------------------------
g = read.csv("GOM.csv")
#Date
g$date <- with(g, sprintf("%02d/%d", Month, Year))

names(g)[names(g)=="DECSLAT"] = "lat"
names(g)[names(g)=="DECSLON"] = "long"
g1 = g[,c("date", "lat", "long")]



# Write CSV ---------------------------------------------------------------

write.csv(p1, file = "Peru3.csv", row.names = F)
write.csv(a1, file = "Alaska3.csv", row.names =F)
write.csv(g1, file = "GOM3.csv", row.names = F)


# Write Table -------------------------------------------------------------

write.table(p1, file = "Peru3.txt", row.names = F)
write.table(a1, file = "Alaska3.txt", row.names =F)
write.table(g1, file = "GOM3.txt", row.names = F)
