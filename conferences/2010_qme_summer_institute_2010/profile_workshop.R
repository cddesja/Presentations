###########################################################################
## This script is for the QME Summer Institute 2010:                     ##
## Profile Analysis Workshop                                             ##
##                                                                       ##    
## Copyright (C) 2010 Christopher David Desjardins                       ##
## This program can be redistributed and/or modified under the terms     ##
## of the GNU Public License, version 3.                                 ##
##                                                                       ##
## http://cddesjardins.wordpress.com                                     ##
##                                                                       ##
###########################################################################

# First, we need to 'load' the profile.R script
source("profile_analysis-0.1.R")

# See what was included in the script
ls()

# criterion.pattern() is the criterion pattern function
# which requires X, Y, and k. X is matrix of predictors;
# Y is a vector of the criterion; k is the scalar constant
#
# profile.cv() is the cross validation function
# which requires X and Y. X is matrix of predictors;
# Y is a vector of the criterion
#
# print.critpat and plot.critpat are the print and plot functions
# for the class 'critpat'
#
# IPMMc is the predictor matrix from Table 1 in Davison & Davenport, 2002
# NP is the criterion vector from Table 1 in Davison & Davenport, 2002

####################
# Drop Out Example #
####################

# We need to load the data set and assign to the drop object.
drop <- read.csv("drop.csv", header=TRUE, sep=",")

# Examine the first few cases
head(drop)
dim(drop)
names(drop)

# The criterion is "Finish" in column 1 and the other columns are predictors
# Now we'll call the function.
drop.crit <- criterion.pattern(X=drop[,2:ncol(drop)],Y=drop[,1],k=1)

# What is actually contained in 'drop.crit'
str(drop.crit) # See Manual for what each part does
# There is a lot of information stored in the object.

# This prints the default information stored in drop.crit
drop.crit

# This plots the criterion pattern vector
plot(drop.crit)


#########################
## Math course example ##
#########################

# Load in the data set for math courses.
math <-read.csv("course.csv",header=TRUE,sep=",")
dim(math)
names(math)

# Examine the last few cases
tail(math)

# Run the criterion.pattern() and store it in math.crit
math.crit <- criterion.pattern(X=math[,6:13],Y=math[,5],k=1)

# Again what does this is in math.crit
str(math.crit)

# Print the default output
math.crit

# Graph the criterion pattern vector
plot(math.crit)

####################
# Cross Validation #
####################

# Dropout example
drop.cv <- profile.cv(X=drop[,2:ncol(drop)],Y=drop[,1])
drop.cv

# Math course example
math.cv <- profile.cv(X=math[,6:13],Y=math[,5])
math.cv
