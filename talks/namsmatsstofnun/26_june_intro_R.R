# Introduction to R
# Christopher David Desjardins
# 26 June 2015
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

install.packages("irtoys")  # IRT models
install.packages("ltm")  # latent trait models, 1, 2, 3-PL models, GR, GPCM
library(nlme)  # HLM models
install.packages("lme4")  # HLM aka mixed effects modeling, can do Rasch modeling
install.packages("lavaan")  # CFA, SEM simple output/model syntax to MPlus
install.packages("sem")  # Another SEM program
install.packages("psych")  # CTT, FA, http://personality-project.org/r/
install.packages("plyr")  # Data manipulation
install.packages("reshape")  # Reshaping data from wide to long format
install.packages("ggplot2")  # Graphing package 
install.packages("equate")  # Equating
install.packages("profileR")  # Profile analysis
install.packages("mice")  # multiple imputation
install.packages("mirt")  # multidimensional IRT

# Load a library
library(foreign)  # This is library needs to be loaded to read SPSS data

# List the functions in a particular package
lsf.str("package:foreign")

# To see vignettes
vignette()
vignette("Guide")

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
setwd("build/github/Presentations/namsmatsstofnun")

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

# Don't worry R won't be so bad ;)

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
library(psych)
?describe
describe(precol)  # asterisks indicate factors

# Conditional tables, useful for factors
table(precol$GENDER,precol$ETHDESCR)

# If you want conditional means the best way is to use the 
# plyr package
library(plyr)
?ddply

# Let's get the mean ACT_MATH by gender
ddply(precol, .(GENDER), summarize, 
      means = mean(ACT_MATH))
# The NA indicates we have missing data

?mean  # The default is to leave NAs in, which we don't want
ddply(precol, .(GENDER), summarize, 
      means = mean(ACT_MATH, na.rm = TRUE))

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
qplot(x = ACT_MATH, y = STATGRAD, data = precol)

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
t.test(ACT_MATH~GENDER, data = precol, var.equal = TRUE)

ddply(precol,.(GENDER), summarize,
      variances = var(ACT_MATH, na.rm = T))

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
# Section 5. Multiple imputation
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

#
# Section 6. IRT and latent variable modeling
#
library(irtoys)

###data set of 75 items, scored dichotomously for 1000 individuals
person.resp <- read.csv(file = "person.resp.csv",header=T)

# Omit the first column because it's really just an ID variable and will
# give the model a headache
person.resp <- person.resp[,-1]

# Make sure the responses are "matrix" in form, not "dataframe":
person.resp <- as.matrix(person.resp)

?est

## We will do this a different way as well but it will be the same thing.

# The irtoys function to estimate item parameters: est (seems obvious)

# Here are some of the arguments of the est command:
#   1) The first command tells R which response matrix contains the (0,1)
#      responses where persons go down the rows and items go across the columns.
#   2) Next, we tell R that we want to assume the responses came from a 1PL,
#   3) We specify WHO (program or function) is doing the estimation:
#       In this case, we're using "ltm," built into R!
#   4) We need to tell R the number of quadrature points, to integrate out the
#      ability! This is really something that you can usually just leave at the default value.
#   5) Finally, R needs to know whether to force a = 1 (rasch = T) or let
#

###setting up the 1PL model  
Try.1PL <- est(person.resp, model="1PL", engine="ltm")
Try.1PL

##rows are per item, the columns are are a, b, and c, respectively
## column 1 then is the item discrimination, notice this is the same for all the parameters
## column 2 is the item difficulty, notice this changes for each item
## column 3 is the guessing parameter, notice this is set to zero 

# Plot 3 items from this data set
MAX <- which.max(Try.1PL$est[,2])
MIN <- which.min(Try.1PL$est[,2])
CloseZero <- which.min(abs(0 - Try.1PL$est[,2]))

## Let's plot the item reponse functions
plot(irf(Try.1PL$est[c(MAX,MIN,CloseZero),], x= seq(from=-10,to=10,by=.1)),co=NA)

############
# Item Fit #
############

# First, we want to check the fit of the 1PL (ltm) parameters:
# To make everything uniform, we will change the name of the params! :)
ltm.params <- Try.1PL

# We're going to calculate fit statistics from a for loop!!!
# We will pull out an item, calculate fit on that item, store it ...

# Though, we need to set up the matrix to store the items:
print(n.it <- ncol(person.resp))

# We will set up a blank matrix:
#   1) The rows will store each item,
#   2) The column will store each of the fit statistics for the items,
#   3) stat (the statistic!), dfr (degrees of freedom), pval (ummm ... p-value?)
item.fit <- matrix(0, nrow = n.it, ncol = 3)

# We want to repeat this for EACH item:
for (i in 1:n.it){
  
  # i is our item index, telling R which item to pull out:
  item <- i
  
  # Now, we can call "item" instead of "i" (to make things easier to read)
  
  # For that item, we want to calculate fit statistics:
  #   1) Plug in the (0, 1) response matrix
  #   2) Plug in the estimated parameters (now, we're trying the 1PL stuff)
  #   3) Tell R which item for which to calculate statistics (i or item)
  #   4) Say what type of fit statistic (we'll do "likelihood ratio")
  #   5) Finally, tell R whether to plot the items and statistics (or not):
  fit.temp <- itf(resp = person.resp, ip = ltm.params$est, item, stat = "lr",
                  do.plot = FALSE, main = paste("Item Fit: Item", item))
  
  # Pull out the "lr" statistic and put it into the 1st column of the ith variable
  # Pull out the "df" and put it into the 2nd column of the ith variable
  # Pull out the "pval" and put it into the 3rd column of the ith variable
  item.fit[i, 1] <- fit.temp[1]
  item.fit[i, 2] <- fit.temp[2]
  item.fit[i, 3] <- fit.temp[3]
}

# So, now we have a matrix of 75 rows (one for each item),
#     and 3 columns (one for each statistic), and maybe a couple warnings :)!

# Next, let's look at the how well "ltm" did with the 1PL:
# First, round to make things easier to see!
ltm.item.fit <- round(item.fit, 3)

# What was the mean Likelihood Ratio Statistic?
mean(ltm.item.fit[ , 1])

# What was the maximum Likelihood Ratio Statistic?
max(ltm.item.fit[ , 1])

# Which item HAD the maximum Likelihood Ratio Stat (Worse Fitting Item!!!)
which.max(ltm.item.fit[ , 1])

# Plot That Item!
itemH <- which.max(ltm.item.fit[,1])
itf(person.resp, ltm.params$est, itemH, stat = "lr",
    do.plot = TRUE, main = paste("Item Fit: Item", itemH))
# Oh how ugly!!!

# Which item HAD the minimum Likelihood Ratio Stat (Worse Fitting Item!!!)
which.min(ltm.item.fit[ , 1])

# Plot That Item!
itemL <- which.min(ltm.item.fit[,1])
itf(person.resp, ltm.params$est, itemL, stat = "lr",
    do.plot = TRUE, main = paste("Item Fit: Item", itemL))
## Much nicer!


# Plot them side by side
par(mfrow=c(1,2))
itf(person.resp, ltm.params$est, itemH, stat = "lr",
    do.plot = TRUE, main = paste("Item Fit: Item", itemH))
itf(person.resp, ltm.params$est, itemL, stat = "lr",
    do.plot = TRUE, main = paste("Item Fit: Item", itemL))

# Remember: High LR -- Line Not Fitting Probabilities
#           Low LR -- Line Pretty Good Est of Probabilities
#           Pretty Sensitive to Slight Deviations from Fit!

# Activity: Chose any item to investigate. Does it fit based on the likelihood ratio test? How does the line fit
# the probabilities?

# Remember the definitions of Information in Estimation:
#   For Everything: expected negative second derivative of log likelihood
#	 For IRT, this becomes: (pprime)^2/(pq)

# The "expected negative second ... " just means the "curvature" of the
# likelihood function!

# Now, we want to work with the function "iif" in irtoys!
# iif takes two (and only two) arguments:
#	1) The item parameters in "matrix" form ... or
#	1) AN item parameter as a "vector"
#	2) A sequence of theta values on which to calculate information ... or
#	2) Nothing, and irtoys will pick the theta values: 99 between [-4, 4]


params.iif <- iif(ltm.params$est)

# Let's see what this object gives us:
names(params.iif)

# There are two drawers (sub-objects):
#	1) x: the thetas at which R evaluated information
#	2) f: the actual information values!

# However, staring at information is mindnumbing ... (as usual)
# But, we don't need to stare ... R can actually plot this object!  Neat!               

plot(params.iif)  
## These are all the information functions! 

# For item 1 
plot(y=params.iif$f[,1],x=params.iif$x, type = "l")

# QUESTION: What does this tell you about the item difficulty (i.e where is it located?)?      
ltm.params$est[1,2]

# QUESTION: Plot the 50th item. Where is the information at a maximum?

#############################
# Item and Test Information #
#############################

# Remember, Item Info is Summative: TIF = sum(IIF)

# Let's find information for a short test!
# First, let's choose the items that we want to be apart of the test:
test.items <- c(10, 30, 35, 40, 45, 50, 70)

# Above are numbers corresponding to the "item numbers", not the items themselves!

# Now, let's take those items out of the "item.params" object:
test.params <- ltm.params$est[test.items, ]

# So we have a combination function:
#	1) "test.items" is a vector of numbers corresponding to item numbers on the test
#	2) [test.items, ] takes ROWS out of item.params corresponding to item numbers
#		So: pulling out the 10th row, the 30th row, ...
#	3) [test.items, ] keeps ALL of the columns of item.params
#		So: pulling out the 10th row (all columns), the 30th row (all columns), ...
#	4) We're taking the items we want, keeping all the parameters of those items, and
#		sending the whole thing to "test.params"

nrow(test.params)

# test.params contains all of the items we wanted!  All seven of them!

# Let's pick a few thetas to run:
thet <- c(-3, -2, -1, 0, 1, 2, 3)

# Next, let's run the function "iif" with a matrix to see what happens:
info.20 <- iif(test.params, thet)

# What is contained in the object?
names(info.20)

# What does the object look like?
info.20

# So, it's the same thing as before, only "x" has changed (to OUR thet), and
# NOW we have a column corresponding to EVERY item in our test!

# Let's use the "apply" command to sum all of the info:
#	1) apply(object, margin, function)
#	2) So, we stick in our matrix of information: info.20$f
#		(we're summing "f", NOT "x", so we don't have to worry about "x")
#	3) Rows are thetas, columns are items, so we want to sum ACROSS the rows
#	4) Our function is "sum", which is a "vector-function"

tinfo.20a <- apply(info.20$f, 1, sum)

# Try the whole thing using the "tif" command instead of the "iif" command:
# (the "tif" is the SAME as "iif", only it finds "test information")

# So, include the SAME parameters we used AND the thetas at which we evaluated:
tinfo.20b <- tif(test.params, thet)

# Let's see if they're the same:
tinfo.20a
tinfo.20b$f

# We can also plot test information in EXACTLY the same way as item information,
# only with a "test" of responses rather than an item of responses:
plot(tif(test.params))

# QUESTION: How does the test look?  Is it a good test?  Is it a bad test?

# Compare the "short test" (of 7 items) with the ENTIRE test (of 75 items)
plot(tif(ltm.params$est))

# QUESTION: Why is the TIF located around the values they are?

####################
# Person Estimates #
####################

# There are 3 estimation methods
# The expected a posteriori estimate 
# Get estimates of person abilities
th.eap <- eap(person.resp,ltm.params$est, qu = normal.qu())

# Examine first few cases
head(th.eap)
# Est corresponds to their estimate person ability
# SEM is the standard error of measurement
# n is the number of non-missing responses

# Getting the estimate using marginal maximum likelihood
th.mle <- mlebme(person.resp,ltm.params$est)
head(th.mle)

# Can also get the maximum a posteriori estimate
th.map <- mlebme(person.resp,ltm.params$est,method = "BM")
head(th.map)

# These estimates are very close, as they should be. 

# 
# Section 7. SEM and CFA
# 

# For CFA and SEM, please refer to 
# http://lavaan.ugent.be/tutorial/index.html
# There is lots of great information there! 


