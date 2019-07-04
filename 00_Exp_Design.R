# Experimental Design Setup and Randomized Assignment of Units to Sampling Days

# Packages
library(tidyverse)

# Functions
'%ni%'=Negate("%in%")

# Create variable columns
biotreatment=rep(c("Blank","Bact","Bact+Am","Unfiltered"),each=24,3)
temp=rep(c(15,20,25),each=24*4)
soiltreatment=rep(c("intact","crushed"),each=12,12)
replnumber=rep(1:12,24)
sampleid=paste0("SP-",01:288)
group = rep(letters[1:24],each=12)

dat = as.data.frame(cbind(sampleid,replnumber,biotreatment,temp,soiltreatment,group))
dat$sampleid <- as.character(dat$sampleid)

# Randomly sample 3 replicates for each time point and each group
set.seed(123)
day0 <- dat %>% group_by(group) %>% sample_n(3,replace=FALSE)
day0$day <- 0
dat=dat[dat$sampleid %ni% day0$sampleid,]  

day15 <- dat %>% group_by(group) %>% sample_n(3,replace=FALSE)
day15$day <- 15
dat=dat[dat$sampleid %ni% day15$sampleid,]  

day30 <- dat %>% group_by(group) %>% sample_n(3,replace=FALSE)
day30$day <- 30
dat=dat[dat$sampleid %ni% day30$sampleid,]  

day60 <- dat %>% group_by(group) %>% sample_n(3,replace=FALSE)
day60$day <- 60
dat=dat[dat$sampleid %ni% day60$sampleid,]  

# Create new data frame with 'day' column
dat2 = rbind(day0,day15,day30,day60)
dat2 = dat2 %>% arrange(group)
dat2$SampleDate <- "yyyy-mm-dd"

# Write Output
write.csv(dat2,"./spreadsheets/exp_design.csv",quote = FALSE,row.names = FALSE)

# Experimental Design 2 - No Soil Treatment (Use intact soils only to simplify everything) ####
# This gives 6 replicates per treatment instead of 3

# Create variable columns
biotreatment=rep(c("Blank","Bact","Bact+Am","Unfiltered"),each=24,3)
temp=rep(c(15,20,25),each=24*4)
replnumber=rep(1:24,12)
sampleid=paste0("SP-",01:288)
group = rep(letters[1:12],each=24)

dat = as.data.frame(cbind(sampleid,replnumber,biotreatment,temp,group))
dat$sampleid <- as.character(dat$sampleid)

# Randomly sample 3 replicates for each time point and each group
set.seed(123)
day0 <- dat %>% group_by(group) %>% sample_n(6,replace=FALSE)
day0$day <- 0
dat=dat[dat$sampleid %ni% day0$sampleid,]  

day15 <- dat %>% group_by(group) %>% sample_n(6,replace=FALSE)
day15$day <- 15
dat=dat[dat$sampleid %ni% day15$sampleid,]  

day30 <- dat %>% group_by(group) %>% sample_n(6,replace=FALSE)
day30$day <- 30
dat=dat[dat$sampleid %ni% day30$sampleid,]  

day60 <- dat %>% group_by(group) %>% sample_n(6,replace=FALSE)
day60$day <- 60
dat=dat[dat$sampleid %ni% day60$sampleid,]  

# Create new data frame with 'day' column
dat2 = rbind(day0,day15,day30,day60)
dat2 = dat2 %>% arrange(group)
dat2$SampleDate <- "yyyy-mm-dd"


# Write Output
write.csv(dat2,"./spreadsheets/exp_design2.csv",quote = FALSE,row.names = FALSE)
