
library(tidyr)
library(dplyr)

####################################################
# separate() and unite() commands
####################################################

set.seed(1)
dta <- data.frame(indicator=c("someindicator2001", "someindicator2011",
                              "some text 20022008", "another indicator 2003",
                              "test123abc"),
                  values = runif(n = 5))

dta
separate(dta, indicator, c("indicator", "period"), "(?<=[a-z]) ?(?=[0-9])")
mtcars
unite_(mtcars, "vs,am", c("vs","am"))

# Separate is the complement of unite
mtcars %>%
  unite("vs_am", vs, am) %>%
  separate(vs_am, c("vs", "am"))
# }


##########################################
# SAMPLING FOR CASE-CONTROL STUDY
##########################################
## sample after grouping variable

controls<-data.frame(AgeSex = c("F42", "F42", "M21", "M21", "M21",
                                "M21", "F15", "F15", "F15", "M81",
                                "M21", "M21", "M21"),
                     MRN = c(1,2,3,4,5,6,7,8,9,10,11,12,13))
cases<-data.frame(AgeSex =c("F42", "M21", "F15", "M21"),
                  MRN = c(14,15,16,17))

#if you want the same selection every time you can set the seed like this:
set.seed(400) #any number
#shuffle the rows of controls
controls<-controls[sample(nrow(controls)),]

match<-controls%>%filter(AgeSex%in%unique(cases$AgeSex))%>%
  group_by(AgeSex)%>%
  slice(1:3)

  
  

