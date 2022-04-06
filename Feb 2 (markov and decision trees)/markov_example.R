
#matrix math in R

TP<-matrix(c(0.8,0,0,0,
             0.15,0.85,0,0,
             0,0.1,1,0,
             0.05,0.05,0,1), nrow=4, ncol=4)
TP


#intial conditions
states<-matrix(c(1000,20,5,10), nrow=1)
states


#multiplying matrices
states %*% TP
#notes that if you switch the order, it's can't compute:
TP %*% states

#Now let's do these calculations in a loop - and keep track of time
states<-data.frame(time=1,
                   well=1000,
                   sick=20,
                   dead=5,
                   dead.other=10)


  i<-1
  temp<-as.matrix(states[i,2:5])%*%TP
  temp
  states[i+1,]<-c(i+1, temp)
  states
  
  i<-2
  temp<-as.matrix(states[i,2:5])%*%TP
  temp
  states[i+1,]<-c(i+1, temp)
  states
  
  
  
  states<-data.frame(time=1,
                     well=1000,
                     sick=20,
                     dead=5,
                     dead.other=10)
  
  
for(i in 1:25){
  temp<-as.matrix(states[i,2:5])%*%TP
  temp
  states[i+1,]<-c(i+1, temp)
}
  
states
states<-states%>%mutate(check = well + sick+dead+dead.other)

library(dplyr)
plot<-states%>%gather(state, number, -time)

library(ggplot2)
ggplot(plot, aes(x=time, y=number, color=state))+
  geom_line()


## looks like there is also a multi-state-modelling package that might do this:
# https://cran.r-project.org/web/packages/msm/vignettes/msm-manual.pdf
# but this is seemingly more useful if you have actual chain data and want to fit a markov model
#



