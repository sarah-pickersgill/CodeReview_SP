library(tidyr)
library(dplyr)

#########################################
#example using ifelse() logic
#########################################

df<-data.frame(columnA = c(1,2,3,4,3,NA),
               columnB = c(NA,5,7,78,4,3))

#different bracketing arrangements:
df<-df%>%mutate(columnC = ifelse(columnA==3 & columnB==7 | is.na(columnB), 1,0),
                columnD = ifelse((columnA==3 & columnB==7) | is.na(columnB),1,0),
                columnE = ifelse(columnA==3 & (columnB==7 | is.na(columnB)),1,0)
                )

########################################
##example using gather()
########################################

df<-data.frame(id = c(111,222,333,444,555),
               A = c(1,0,0,0,NA),
               B= c(0,1,1,NA,NA),
               C= c(0,0,0,1,1))

df<-df%>%gather(category, test, -id)
df<-df%>%filter(test==1) 
df<-df%>%select(-test)

#you can also do this all in one line like so:

df<-data.frame(id = c(111,222,333,444,555),
               A = c(1,0,0,0,NA),
               B= c(0,1,1,NA,NA),
               C= c(0,0,0,1,1))

df<-df%>%gather(category, test, -id)%>%filter(test==1)%>%select(-test)




