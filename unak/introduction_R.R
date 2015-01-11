# Introduction to R
# Christopher David Desjardins
# 12 January 2015
#
# Section 0. Installing R & Rstudio
#
# These are comments. You can run these lines of code (Ctrl + Enter) 
# and R will not run them.
# 2 + 2
2 + 2
# For R, http://cran.uib.no/  
#
# If you are installing the Windows version, click "base" subdirectory
# There is no reason (that I'm aware of) to use 32 bit R if you can
# use 64 bit R.
#
# For Rstudio, http://www.rstudio.com/products/rstudio/download/ 
# You want the Open Source Edition (this is a new phenomenon).
#
# There are other ways to interact with R
# If you use Mac, the Rgui by itself is fine
# If you use Emacs, http://ess.r-project.org/
# 
# The closest thing to a GUI for R is Rcmdr
install.packages("Rcmdr")  # This only needs to be done once
library(Rcmdr)
# If you think you'll use Rcmdr then you probably want to install
# the extra packages. However, I would recommend against using 
# a GUI as it will be slower and makes me reproducibility harder.
#
# Rstudio is a nice IDE for R for both beginner's and power users.
# I'd recommend learning Rstudio, it's open-source, so it isn't
# going away.
#
# Section 1. Customizing Rstudio
# 
# Much of the Rstudio IDE is customizable. By default Rstudio
# has soft-wrap R sources files disabled. This might be something you
# wish to enable to prevent very long lines. I would recommend
# just breaking your lines after 80 characters or so anyways.
# You can find these settings under Tools -> Global Options
#
# You can also change the pane layout if you want.
#
# By default, the following layout is used.
# Upper Left - Code editor
# Bottom Left - R console 
# Upper Right - Environment, i.e. what is currently in R and History, i.e.
# what commands you have run.
# Bottom Right - Viewer for help pages, files in current directory, graphs,
# and packages. 
#
# This layout is generally OK.
#
# You'll always want write code in the Code editor and not directly in the 
# R console unless it's something you know you'll never want to write again!
#
# Section 2. R Basics
#
# Some books:
# Using R for Introductory Statistics: http://cran.r-project.org/doc/contrib/Verzani-SimpleR.pdf
# Linear models with R: http://www.amazon.com/Linear-Models-Chapman-Statistical-Science/dp/1584884258
# Extending the linear model with R: http://www.amazon.com/Extending-Linear-Model-Generalized-Nonparametric/dp/158488424X
#
# However, there's lot of R resources. So unless you want a printed R book
# you don't need to buy one. 
# What I do is often just Google my problem and I either hit 
# stackoverflow or the R-help mailing list. There are also lots of wonderful
# blogs. 
# http://www.statmethods.net/
#
# For Icelandic R videos: https://www.youtube.com/channel/UClpgj8pTFS3XT5SHYWpAbrQ
# These are R videos and statistics tutorials for the stats department at HÍ.
#
# R is programming language and a statistics environment

# To install a library in R use the install.package() function
# Some libraries of interest here.
# R will figure out all it's dependencies automatically

install.packages("irtoys")  # IRT models
install.packages("ltm")  # latent trait models, 1, 2, 3-PL models, GR, GPCM
library("nlme")  # HLM models
install.packages("lme4")  # HLM aka mixed effects modeling, can do Rasch modeling
install.packages("lavaan")  # CFA, SEM simple output/model syntax to MPlus
install.packages("sem")  # Another SEM program
install.packages("GPArotation")  # Factor rotations
install.packages("psych")  # CTT, FA, http://personality-project.org/r/
install.packages("plyr")  # Data manipulation
install.packages("reshape")  # Reshaping data from wide to long format
install.packages("ggplot2")  # Graphing package 
install.packages("equate")  # Equating
install.packages("mice")  # multiple imputation
install.packages("mirt")  # multidimensional IRT
install.packages("dplyr")  # Another data manipulation package with better syntax


# Some packages are also on GitHub, a site for coders to share code
install.packages("devtools")  # need for GitHub
library("devtools")
install_github(repo = "cddesja/profileR", ref = "develop")

# Load a library
library("foreign")  # This is library needs to be loaded to read SPSS data
library("profileR")  

# List the functions in a particular package
lsf.str("package:profileR")

# To see vignettes, either PDF or HTML
vignette()
vignette("release")  ## ggplot2 vignette

# To find out information about a function:
?read.spss  # In spite of the cavaet, I have had no issues with this function

# To search for a keyword
??item

# What data sets are available?
data()

# Which data sets belong to ltm, irtoys, and lme4?
data(package = c("lme4","ltm","irtoys"))

# Check what directory we're working from and set it
getwd()
setwd("~/Dropbox/Presentations/unak/data/")

# To see what's in that directory
dir()

# Import the STAT_PRECOLLEGE dataset from SPSS
# "<-" this is the assignment operator
precol <- read.spss(file = "STAT_PRECOLLEGE.sav", to.data.frame = T)
# I recomend always naming objects in lowercase.
# If you want to combine words use lower.case

# Note that precol appears in the Environment window (UR)
# You can also see that by running ls() in R
ls()
# You can also note the History tab

# Investigate the first few cases
head(precol)

# and the last few
tail(precol)

# view all data
precol

# If you want to see a specific observation, say #20, and you want to see responses from variables 2 through 3
precol[20,2:3]

# Or if you want to see variables 1, 3, and 6 for observations 19 through 21.
precol[19:21, c(1,3,6)]

# To get information about the data set and the variable types
str(precol)

# To get the variable labels
attr(precol,"variable.labels")

# To get the name of all the variables
names(precol)

# To write the data to a text file in your working directory
write.table(precol,file = "precol.txt", row.names = FALSE)
write.csv(precol, file = "precol.csv")

# To read it back in
read.table(file="precol.txt")

# But we need to save it as an object
precol.tmp <- read.table(file="precol.txt")

# Similar functions exist to read data directly from CSV files, SAS files, etc.
# Check out the foreign package 

# To get summary data of the data.frame
summary(precol)

# To access a variable in the data.frame use the "$" symbol 
precol$GENDER  # fyi, R is case sensitive

# To get a table of this
table(precol$GENDER)
# We see that the baseline group is F and that M are the reference

# Let's a unique ID variable to this data set
precol$id <- 1:nrow(precol)  # nrow(), number of rows in the data.frame
head(precol)

# What if we found out subject 1 should had a ACT_ENGL of 20 not 16
precol[precol$id == 1,]
precol[precol$id == 1, "ACT_ENGL"]
precol[precol$id == 1, "ACT_ENGL"] <- 20
precol[precol$id == 1, "ACT_ENGL"]

# Can use the psych library to get even more information 
library("psych")
?describe
describe(precol)  # asterisks indicate factors

# Conditional tables, useful for factors
table(precol$GENDER,precol$ETHDESCR)

# If you want conditional means the best way is to use the 
# plyr package
library("dplyr")
?dplyr
browseVignettes(package = "dplyr")

# Let's get the mean ACT_MATH by gender
precol %>%
  group_by(GENDER) %>%
  summarize(MEANS = mean(ACT_MATH))
# The NA indicates we have missing data

?mean  # The default is to leave NAs in, which we don't want
precol %>%
  group_by(GENDER) %>%
  summarize(MEANS = mean(ACT_MATH, na.rm = T))

# Let's say we want to do a median split on ACT_MATH for some reason.
precol$math_split <- ifelse(precol$ACT_MATH > median(precol$ACT_MATH, na.rm = T), "High","Low")
table(precol$GENDER,precol$math_split)

# How many levels of factor are there
nlevels(precol$LTRGRADE)
levels(precol$LTRGRADE)  # lists the levels

# Remove a variable
precol$math_split <- NULL

#
# Section 3. Graphing
#

# Graphing can be accomplishing using just the R base libraries
# But, graphing is greatly expanded with ggplot2
# We'll use both and that's what I would recommend

# Scatterplots
# If you try to run a function when the library isn't loaded you'll get this
# message
library(ggplot2)
qplot(x = ACT_MATH, y = STATGRAD, data = precol)

# That is identical to this
ggplot(aes(x = ACT_MATH, y = STATGRAD), data = precol) + geom_point()

# The advantage of the second line is that you'll often build up and change
# graphs.
g0 <- ggplot(aes(x = HSPR, y = ACT_MATH), data = precol)
g0 + geom_point() + theme_bw()  # let's give it a black and white theme
g0 + geom_point(col = "orange") + theme_bw()  # bw theme and orange points
(g1 <- g0 + geom_point(col = "orange", shape = 2) +
  theme_bw())  # bw theme and orange triangles, () echo
(g1 <- g0 + geom_point(aes(colour = GENDER), shape = 2) +
   theme_bw()) 

# Add a best fit
(g2 <- g1 + stat_smooth(aes(color = GENDER),method = "lm", formula = y ~ x))

# And a smoother
g1 + geom_smooth(aes(color = GENDER))  # Linear model is inappropriate?

# Continue to modify the graph and polishing it a little
g2 + xlab("High School Percentile Rank") + ylab("ACT Math") + 
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom") +
  ggtitle("ACT Math vs. High School Percentile Rank")

# Box plot
ggplot(aes(y = HSPR, x = GENDER), data = precol) + geom_boxplot()
ggplot(aes(y = HSPR, x = GENDER), data = precol) +
  geom_boxplot(aes(fill = GENDER), outlier.colour = "green" )
# Sometimes British English is required 

# Marginal plot of HSPR
ggplot(data = precol, aes(HSPR)) + geom_histogram(fill="white", color = "red") +
  xlab("High School Percentile Rank") + ylab("Frequency")

ggplot(data = precol, aes(HSPR)) + geom_histogram(fill="white", color = "red") +
  xlab("High School Percentile Rank") + ylab("Frequency") + facet_grid(.~GENDER)

ggplot(data = precol, aes(HSPR)) + geom_histogram(aes(fill=ETHDESCR), color = "red") +
  xlab("High School Percentile Rank") + ylab("Frequency") + facet_grid(GENDER~ETHDESCR) 

# Change data type, remember id shouldn't really be numeric
precol$id <- as.factor(precol$id)

# Section should also be a factor
precol$SECTION <- as.factor(precol$SECTION)

# Subset only the continuous variables
numer <- NULL
for(i in 1:ncol(precol)){
  numer[i] <- is.numeric(precol[,i])
}
cont.var <- precol[,numer]
head(cont.var)

# Scatterplot matrix
pairs(cont.var)
pairs.panels(cont.var)

# Correlation matrix
cor(cont.var)
?cor
cor(cont.var, use = "complete.obs")

# Extra plotting help visit: http://docs.ggplot2.org/current/
# Lots of great stuff there.

#
# Section 4. Regression and ANOVA
#

# t-test
t.test(ACT_MATH~GENDER, data = precol)

# As a regression
m0 <- lm(ACT_MATH ~ GENDER, data = precol)
summary(m0)

precol$white <- ifelse(precol$ETHDESCR == "White     ", "White","Non-White")
table(precol$white)
precol$red.ethnic <- ifelse(precol$ETHDESCR == "White     ", "White",
                            ifelse(precol$ETHDESCR ==  "Black     ", "Black", "Other"))

red.ethnic <- ifelse(precol$ETHDESCR == "White     ", "White",
                     ifelse(precol$ETHDESCR ==  "Black     ", "Black", "Other"))

# Which is of course also a one-factor ANOVA
anova(m0)

# Note, that the p-values were close but not identical. 
t.test(ACT_MATH~GENDER, data = precol, var.equal = FALSE)

precol %>% 
  group_by(GENDER) %>%
  summarize(VARIANCES = var(ACT_MATH, na.rm = T))

# m0 contains information
str(m0)  # it's a list of 14 items

# Can access these directly
m0$coef
m0$residuals

# Or through R commands
coef(m0)
print(residuals(m0), digits = 2)

# You can get a lot of diagnostic information from plotting model
plot(m0)

# Simple linear regression
m1 <- lm(CUM_GPA ~ ACT_TOTL, data = precol)
summary(m1)
plot(m1)  # model looks pretty reasonable

# Box-Cox transformation
library(MASS)
boxcox(m1)

# Multiple regression
m2 <- lm(CUM_GPA ~ HSPR + STATGRAD, data = precol)
summary(m2)

# ANOVA
m3 <- lm(CUM_GPA ~ GENDER + ETHDESCR + GENDER*ETHDESCR, data = precol)
anova(m3)

# Fit the model with everything in it except STATGRAD and id
m4 <- lm(CUM_GPA ~ . - id - STATGRAD, data = precol)
summary(m4)

# Do stepwise selection, but can't have missing data
# Omit missing data
precol.m <- na.omit(precol)
m5 <- lm(CUM_GPA ~ . - id - STATGRAD, data = precol.m)

# Stepwise (unwise) selection
step.mod <- stepAIC(m5)
summary(step.mod)

#
# Section 5. IRT and latent variable modeling
#
# MIRT - Multidimensional Item Response Theory package

# Load the package
library("mirt")

# Let's use the LSAT7 data
# The Law School Admissions Test, Section 7
data(LSAT7)  # loads data
head(LSAT7) 

# We notice that there are 5 items from the LSAT7 and the final column corresponds to the number of times 
# this pattern was observed. These items are dichotomously scored. There should be a total of 32 patterns, which should be the number of rows. 
# 2^5.

# Always good to look at the data 
summary(LSAT7)

# The main function we'll be using is mirt()
# mirt() can do everything ... literally ...
?mirt

# The main argument we are concerned with is itemtype
# The other arguments matter too but will be used on a case by case manner

# First, we need to expand this data set so that it's represented of all the subjects 
# taking the test
lsat.data <- expand.table(LSAT7)
head(lsat.data)
dim(lsat.data) # 1000 subjects
sum(LSAT7$freq) # should match the sum of the frequency

# Let's first fit a Rasch model to the data
# The 1 is for "one-factor"
rasch.mirt <- mirt(lsat.data, 1,itemtype = "Rasch") 

# Let's look at the estimated parameters

# a1, corresponds to the item discrimation
# d, corresponds to the item difficulty
# g, is the guessing parameter
# u, is the sqrt of the factor uniqueness
coef(rasch.mirt)

rasch.mirt
# The provides various fit output measures

# Let's fit a 2-PL model
mirt.2pl <- mirt(lsat.data,1,itemtype = "2PL")
coef(mirt.2pl)

# Finally, let's fit a 3-PL
mirt.3pl <- mirt(lsat.data,1,itemtype = "3PL")
coef(mirt.3pl)

# But was it appropriate to run unidimensional IRT?
oneF <- mirt(lsat.data,1)
twoF <- mirt(lsat.data,2)

summary(oneF)
summary(twoF)
# h2 is the proportion of a manifest variables variance explained by the factor structure (n.b. when rotation is orthogonal this is the sum of their squared factor loadings)

# You can rotate the structure to make is more understandable and suppress loadings
# By default you see it does an oblimin rotation, which is an oblique rotation
# varimax is a common orthogonal rotation
# There are a whole slew of rotations available
# ?GPArotation
# We'll also suppress the loadings that are 0.25

summary(twoF,rotate="varimax", suppress = 0.25) 

## Notice the factor correlation below

# If you want empirically compare the two models
# H_0 is that fit is the same
# reject H_0 means that we favor the more complex model 

anova(oneF,twoF)

# Given this, is it appropriate to even use the one factor model and unidimensional IRT?

# Recall that one of the assumptions is local independence
# i.e. two items are only related to one another through the factor
# and any residual errors should be uncorrelated.
# This can be formally examined

residuals(oneF)

# This prints a local dependence pairwise statistic between the items
# This statistic has a chi-square distribution with 1 df under H_0.
# Formally, extreme values larger than ...

qchisq(.95,df=1)

# Indicate violations of local independence
# This is along the bottom of the triangle

# Standardized Cramer's V, similar to correlations 
# are above the triangle
# This is again evidence that a one-factor model may be in sufficient

# Ability estimates

# Defaults to EAP
# This is expected a posteriori, or Bayes mean estimate
# This is takes the mean of the posterior distribution of the person ability estimates
fscores(rasch.mirt)

# MAP scores
# This is maximum a posteriori, or Bayes modal estimate
# This is takes the mode of the posterior distribution of the person ability estimates
fscores(rasch.mirt, method = "MAP")
# Empircial reliability is the ratio of the variance of the MAP (EAP) thetas to the
# sum of the variance of the thetas and error variance


# The prior distribution is a multivariate normal distribution with a mean vector of 0s
# and an identity matrix for the covariance matrix.
# The mean and covariances can be specified, but it doesn't appear
# as though you are able to change the actual distribution.

# These two estimates are affected by the choice of the prior distribution on the person abilities
# Therefore, if the prior distribution doesn't reflect reality, then these estimates will be biased


# Finally, ML scores
# These are maximum likelihood estimates and are based solely on the data, i.e. the likelihood
fscores(rasch.mirt, method = "ML")
# There is a problem here ...

# Can also set quadrature points here, but again how many?

# Let's see how well these models relate to one another
rs <- as.data.frame(fscores(rasch.mirt, method = "MAP"))
s2pl <- as.data.frame(fscores(mirt.2pl, method = "MAP"))
s3pl <- as.data.frame(fscores(mirt.3pl, method = "MAP"))
scores <- data.frame(rs$F1,s2pl$F1,s3pl$F1)
cor(scores)


#########
# Plots #
#########

# To plot the test information
plot(rasch.mirt)

# To plot the item response functions
plot(rasch.mirt,type = "trace")

# To plot just the irf for item 1
plot(rasch.mirt,type = "trace",which.items= 1)

# To plot the item information functions
plot(rasch.mirt,type = "infotrace", facet_items = TRUE)

# Remove the facet
plot(rasch.mirt,type = "infotrace", facet_items = FALSE)

# To plot just the irf for item 1,2 & 5
plot(rasch.mirt,type = "infotrace",which.items= c(1:2,5))

# test response function, i.e. the expected total score
plot(rasch.mirt,type="score")

#######################
# Comparing model fit #
#######################

# First compare the rasch to the 2PL
anova(rasch.mirt,mirt.2pl)

# Compare the 2PL to the 3PL
anova(mirt.2pl,mirt.3pl) 

# There is no improvement in fit
# With these test also notice there 
# are various fit criteria such as AIC and BIC

# We can plot the 2PL as we did with the rasch
plot(mirt.2pl)
plot(mirt.2pl,type = "trace") 
# From this plot we can see that items 4 and 5 have the lowest discrimation
# and item 3 has the highest

# Let's examine information
plot(mirt.2pl,type = "infotrace") 
# How does this relate to discrimation, a?

# Interactive shiny plot
install.packages("shiny")
library("shiny")
itemplot(shiny = TRUE)

# 
# Section 6. SEM and CFA
# 

# For CFA and SEM, please refer to 
# http://lavaan.ugent.be/tutorial/index.html
# There is lots of great information there! 


#
# Section 7. Multiple imputation
#
# http://www.stefvanbuuren.nl/publications/MICE%20in%20R%20-%20Draft.pdf
library(mice)   

# Pattern of missingness
md.pattern(precol)  

# This is a way to look and see if missingness may be related btwn variables
md.pairs(precol)

# To do imputation can use mice()
?mice
imp <- mice(precol)

# Inspect the results
imp

# Check plausibility of the results
imp$imp$ACT_MATH
nrow(imp$imp$ACT_MATH)
sum(is.na(precol$ACT_MATH))
# Notice it's a 28 x 5 (5 imputations)

# Re-run the regression model
fit <- with(imp, lm(CUM_GPA ~ HSPR + STATGRAD))
fit

# Get pooled results
pool(fit)

# Get summary table with p-values
summary(pool(fit))

