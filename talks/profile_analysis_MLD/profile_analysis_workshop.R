###########################
## From profanal package ##
###########################

# Install the package
install.packages("/Users/chris/Dropbox/Public/profanal/profanal_1.0.tar.gz",type="source")
library(profanal)
?profanal

# From ?profanal
vignette("profanalnotes")
data(IPMMc)
data(NP)
X=IPMMc
Y=NP
p0=criterion.pattern(X,Y,k=100)
str(p0)
p0$lvl.comp
p0$pat.comp
p0$Covpc

###################
## Sack Data Set ##
###################
load("/Users/chris/Dropbox/Documents/university/programming/r/programs/profile_analysis/data/sack.Rdata")
sack.m=na.omit(sack)
criterion.pattern(X=sack.m[,-1],Y=sack.m[,1],k=100)
profile.cv(sack.m[,-1],sack.m[,1])