
library(dplyr)
library(broom)

df<-data.frame(`0-4 years`= c(123,5464,76,87),
               `5-14 years`= c(5645,878,454,23),
               cause = c("stroke", "diabetes", "cancer", "ihd"),
               sex = c("Male", "Male", "Female" ,"Female"))

names(df)[1]<-"0-4 years"
names(df)[2]<-"5-14 years"

df<-df%>%gather(age.group, deaths, -cause, -sex)

df<-df%>%mutate(age.group = gsub(' years', '', age.group))

#make 2 age columns
df<-df%>%mutate(start.age = as.numeric(sub("-.*", "", age.group)),
                stop.age = as.numeric(sub(".*-", "", age.group)))



library(readxl)
#https://readxl.tidyverse.org/reference/read_excel.html

df_xl<-read_xlsx("example.xlsx", sheet="death data", skip = 4)

df_male<-df_xl[ , 4:6]
df_female<-df_xl[,c(4,7,8)]

names(df_male)[2:3]<-c("0-4", "5-14")
names(df_female)[2:3]<-c("0-4", "5-14")

df_male$sex<-"Male"
df_female$sex<-"Female"

df_xl<-bind_rows(df_male, df_female)

df_xl<-df_xl%>%gather(age.group, deaths, -cause, -sex)

df_xl<-df_xl%>%mutate(start.age = as.numeric(sub("-.*", "", age.group)),
                stop.age = as.numeric(sub(".*-", "", age.group)))



###

ex<-data.frame(var1 = c("red", "blue" ,"green", "yellow"),
               pH = c(1,2,6,10))


ex<-ex%>%mutate(var4 = ifelse(var1=="blue", 1, 0))

ex<-ex%>%mutate(var3 = ifelse(var2<5, "acidic",
                              ifelse(var2>=5 & var2<8, "normal", "basic")))


