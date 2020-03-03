# Pick random jars for each sampling period

library(tidyverse)

dat <- read.csv("./spreadsheets/SampleMetadata.csv",stringsAsFactors = FALSE)

set.seed(123)
nums <- 1:36
tp_0 <- sample(nums,6)
tp_1 <- sample(nums[-tp_0],6)
tp_2 <- sample(nums[-c(tp_0,tp_1)],6)
tp_3 <- sample(nums[-c(tp_0,tp_1,tp_2)],6)
tp_4 <- sample(nums[-c(tp_0,tp_1,tp_2,tp_3)],6)
tp_5 <- sample(nums[-c(tp_0,tp_1,tp_2,tp_3,tp_4)],6)

dates <- as.POSIXct(c("2020-03-02","2020-03-09","2020-03-16","2020-03-23","2020-03-30","2020-04-06"))

dat2 <- data.frame(Timepoint=rep(0:5,each=6),
           SampleDate = rep(dates,each=6),
           ReplicateNumber = c(tp_0,tp_1,tp_2,tp_3,tp_4,tp_5))

write.csv(dat2,"./spreadsheets/sampling_design.csv",row.names = FALSE,quote=FALSE)
dat

merge(dat,dat2)
dat3 <- left_join(dat,dat2,"ReplicateNumber")
write.csv(dat3,"./spreadsheets/exp_design.csv",row.names = FALSE,quote = FALSE)
