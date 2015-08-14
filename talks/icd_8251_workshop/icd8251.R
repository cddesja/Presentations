## ---------------------------------------------------- ##
## This is R script for the 8251 ICD workshop           ##
## Copyright (C) 2012 Christopher David Desjardins      ## 
## desja004 AT umn DOT edu                              ##
## This program can be redistributed and/or modified    ##
## under the terms of the GNU Public License, version 3 ##
## ---------------------------------------------------- ##

## This script is meant to replicate the analysis performed in SPSS during the workshop ##

# Reading SPSS files into R
library(foreign)

# Read data into R and save it as the object eclsk
eclsk = read.spss(file.choose(),to.data.frame=T)

# Look at the first few rows in eclsk
head(eclsk)

# Note that R is case-sensitive
head(Eclsk)

# Examine how R reads the variables
str(eclsk)
is.factor(eclsk$GENDER)

# Names of the variables in eclsk
names(eclsk)

# Structure of these variables
str(eclsk)

#--------#
# Graphs #
#--------#

# Histogram of Reading T-score
hist(eclsk$C2R4RTSC,breaks=30,xlim=c(0,100))

# Stem-and-Leaf plot
stem(eclsk$C2R4RTSC,scale=2,width=100)

# Boxplot
boxplot(eclsk$C2R4RTSC)

# Scatterplot
plot(y=eclsk$C2R4RTSC,x=eclsk$C2R4MTSC,xlab="C2 RC4 MATH T-SCORE", ylab="C2 RC4 READING T-SCORE")

#-----#
# EDA #
#-----#

# Central Tendency
y=c(10,1,3,1,6)
mean(y)
median(y)

Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

Mode(y)

# Variability
y=c(7,7,9,2,1)
var(y)
sd(y)
sd(y) == sqrt(var(y))

# Covariance and correlation
x=c(7,18,2,12,3)
y=c(12,14,5,19,1)
cov(x,y)
cor(x,y)
cov(x,y)/(sqrt(var(x)*var(y)))

#--------------------------#
# Simple Linear Regression #
#--------------------------#

# In R, you perform a linear regression, simple or multiple, with the lm() function

# Slope
SXY = sum((x - mean(x))*(y-mean(y)))
SXX = sum((x - mean(x))^2)
beta1=SXY/SXX; beta1

# Intercept
beta0 = mean(y) - beta1*mean(x); beta0

# Confirm
coef(lm(y~x))

# R^2
read5=round(eclsk$C2R4RTSC[1:5])
ses5=round(eclsk$WKSESL[1:5])

y.obs=read5
y.hat=predict(lm(read5~ses5))
y.bar=mean(read5)

SST=sum((y.obs-y.bar)^2); SST
RSS=sum((y.obs-y.hat)^2); RSS
R2 = 1 - RSS/SST; R2
cor(read5,ses5)^2

# Confirm
summary(lm(read5~ses5))$r.squared

# The example in SPSS
m0=lm(C2R4RTSC~WKSESL,data=eclsk)
summary(m0)

#---------------------#
# Multiple Regression #
#---------------------#
mr.ex=lm(C2R4RTSC~C2R4MTSC+WKSESL,data=eclsk)
summary(mr.ex)
plot(mr.ex)[1:2]
hist(rstandard(mr.ex))

# ANOVA and MR
mr=lm(C2R4RTSC~GENDER,data=eclsk)
summary(mr)

# The t-value from MR
t = summary(mr)$coef[2,3]

# The F-statistic from ANOVA
anova(mr)$F[1]
t^2


#-------------#
# T-test & CI #
#-------------#

# Note equivalency between intercept and one-sample t-test
summary(lm(C2R4RTSC~1,data=eclsk))
t.test(eclsk$C2R4RTSC)

# Note a two-sample t-test is equivalent to the regression slope assuming equal variances
t.test(C2R4RTSC~GENDER,data=eclsk,var.equal=T)

# One-Sample t-test
x=c(2,1,2,0,2)
t.test(x)

# Two-Sample t-test equal variance
x1=c(4,2,3,5,3)
x2=c(2,1,2,0,2)
t.test(x1,x2,var.equal=T)

# Two-Sample t-test equal variance
x1=c(5,4,4,5)
x2=c(3,2,2,3,3)
t.test(x1,x2)

# CI
ci.test=lm(C2R4RTSC~1,data=eclsk)
confint(ci.test)

# By hand
beta=51.7083
se=0.1391
crit.value=qt(.975,nrow(eclsk)-1)

beta + c(-1,1)*crit.value*se



#################################################################
## Other helpful functions for 8251 based on the Day 1 handout ##
#################################################################

# Winsorized mean
win<-function(x,tr=.2){
   y<-sort(x)
   n<-length(x)
   ibot<-floor(tr*n)+1
   itop<-length(x)-ibot+1
   xbot<-y[ibot]
   xtop<-y[itop]
   y<-ifelse(y<=xbot,xbot,y)
   y<-ifelse(y>=xtop,xtop,y)
   win<-mean(y)
   win
}
win(eclsk$SEI)

# Trimmed mean
trim<-function(x,tr=.1){
	y=sort(x)
	n=length(x)
	qlow=quantile(y,probs=tr,na.rm=T)
	qhigh=quantile(y,probs=1-tr,na.rm=T)
	y=subset(y,y > qlow & y < qhigh)
	trim=mean(y)
	trim
}
trim(eclsk$SEI,tr=.3)


# Skew
skew<-function(x){
	y=na.omit(x)
	N=length(y)
	Z=(y - mean(y))/sd(y)
	skew=N*sum(Z^3)/((N-1)*(N-2))
	skew
}
skew(eclsk$SEI)

# Kurtosis
kurt=function(x){
	y=na.omit(x)
	N=length(y)
	Z=(y - mean(y))/sd(y)
	kurt=N*(N+1)*sum(Z^4)/((N-1)*(N-2)*(N-3))-3*(N-1)^2/((N-2)*(N-3))
	kurt
}

# Random normal plot
set.seed(8251)
sim.norm=rnorm(1000)
h=hist(sim.norm,breaks=40,col="red",main="",xlab="Z")
xfit<-seq(min(sim.norm),max(sim.norm),length=length(sim.norm)) 
yfit<-dnorm(xfit,mean=mean(sim.norm),sd=sd(sim.norm)) 
yfit <- yfit*diff(h$mids[1:2])*length(sim.norm) 
lines(xfit, yfit, col="blue", lwd=2)
	
# Random t plots
set.seed(8251)
sim.t10=rt(1000,df=10)
plot(density(sim.t10),xlab="t(df=10)")

set.seed(8251)
sim.t30=rt(1000,df=30)
plot(density(sim.t30),xlab="t(df=30)")


# Random F plots
set.seed(8251)
par(mfrow=c(3,1))
hist(rf(1000,4,5),col="red",main="",ylab="",xlab="dftreat=4, dferror=5",breaks=20)
hist(rf(1000,4,15),col="red",main="",ylab="",xlab="dftreat=4, dferror=15",breaks=20)
hist(rf(1000,4,45),col="red",main="",ylab="",xlab="dftreat=4, dferror=45",breaks=20)

# Multiple Regression example
eclsk.m=na.omit(eclsk)
N = nrow(eclsk.m)
X = cbind(rep(1,N),eclsk.m$rincome,eclsk.m$agewed)
Y = eclsk.m$sei

# OLS parameter estimates
B = solve(t(X)%*%X)%*%t(X)%*%Y

# Calculating the residuals by hand
Y.pred=X%*%B
Y.res= Y - Y.pred

# Residual sum of squares
RSS=1/N*sum(Y.res^2)

# Covariance matrix of B
Cov.B = Vhat*solve(t(X)%*%X)

# standard errors correspond to the diagonal elements of this matrix
SE.B = sqrt(diag(VarB))

# To verify in R
m0=lm(eclsk.m$sei ~ eclsk.m$rincome + eclsk.m$agewed)
summary(m0)$coef[,1:2]

# Recall that t = B/SE.B
t = B/SE.B; summary(m0)$coef[,3]

# Finally, p-value
p = ncol(X)
p.value=(1 - pt(t,df=N-p))*2  
# or ...
p.value2 = pt(t,df=N-p,lower.tail=F) + 1 - pt(t,df=N-p)
print(p.value);summary(m0)$coef[,4]

