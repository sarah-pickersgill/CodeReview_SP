# Function to find a and b for the Beta(a,b) prior #
prior_beta <-function(x,q1,q2,p1,p2){(p1-pbeta(q1,x[1] ,x[2]))^2 + (p2-pbeta(q2,x[1] ,x[2]))^2 }
#
p1 <- 0.05 # the lower quantile level
p2 <- 0.95 # the upper quantile level
q1 <- 0.1 # What do you want the lower quantile to be?
q2 <- 0.6 # what do you want the upper quantile to be?
opt <- optim(par=c(1,1),fn=prior_beta ,q1=q1,q2=q2,p1=p1,p2=p2) 

cat("a and b are",opt$par ,"\n")
# Gives the output
# a and b are 2.732585 5.6714 

### To cycle through multiple betas (or gammas): 
# keep prior_beta, p1, p2
# redefine q1, q2
# rename opt.tp (same optim fxn, different object stored)
# call opt.tp$par[1], opt.tp$par[2] inside draw function:
# tp <- rbeta(1,opt.tp$par[1],opt.tp$par[2])


probvals <- seq(0,1,0.001)
plot(probvals ,dbeta(probvals ,shape1=opt$par[1],shape2=opt$par[2]),type="l", xlab=expression(theta),ylab="Beta Density")
abline(v=q1,col="red")
abline(v=q2,col="red")

draw.object<-rbeta(n,a,b) # ncp=F

# Function to find a and b for the Gamma(a,b) prior #
prior_gamma <-function(x,q1,q2,p1,p2){(p1-pgamma(q1,x[1],x[2]))^2 + (p2-pgamma(q2,x[1] ,x[2]))^2 }
#
p1 <- 0.025 # the lower quantile level
p2 <- 0.975 # the upper quantile level
q1 <- 10 # What do you want the lower quantile to be?
q2 <- 30 # what do you want the upper quantile to be?
opt <- optim(par=c(1,1),fn=prior_gamma ,q1=q1,q2=q2,p1=p1,p2=p2) 

shape<-optim(par=c(1,1),fn=prior_gamma ,q1=q1,q2=q2,p1=p1,p2=p2)$par[1] 
rate<-optim(par=c(1,1),fn=prior_gamma ,q1=q1,q2=q2,p1=p1,p2=p2)$par[2] 

cat("a and b are",opt$par ,"\n")
# Gives the output
# a and b are 9.380036 0.4973057 
#shape and rate#


probvals <- seq(0,100,0.001)
plot(probvals ,dgamma(probvals ,shape=opt$par[1],rate=opt$par[2]),type="l", xlab=expression(theta),ylab="Gamma Density")
abline(v=q1,col="red")
abline(v=q2,col="red")

draw.object<-rgamma(n,a,b)

