# Set work environment
setwd("C:\\Users\\Mina\\Desktop\\Data Project")

# Reading datasets
primaries <- read.csv("primaries.csv", header = TRUE, as.is = TRUE)
election <- read.csv("election.csv", header = TRUE, as.is = TRUE)

# Overview of datasets
str(primaries)
str(election)

# Summary of datasets
summary(primaries)
summary(election)

# R reads the % as strings - this will change the strings into numbers without the percentage symbol
primaries$Donald.Trump = as.numeric(sub("%", "", primaries$Donald.Trump))
primaries$Hillary.Clinton = as.numeric(sub("%", "", primaries$Hillary.Clinton))
election$Donald.Trump = as.numeric(sub("%", "", election$Donald.Trump))
election$Hillary.Clinton = as.numeric(sub("%", "", election$Hillary.Clinton))

# Creating Subsets for primaries
Trump_primaries <- subset(primaries,select=c("Donald.Trump"))
Hillary_primaries <- subset(primaries,select=c("Hillary.Clinton"))

# Creating Subsets for election
Trump_election <- subset(election,select=c("Donald.Trump"))
Hillary_election <- subset(election,select=c("Hillary.Clinton"))

# Checking the dimensions of the data frames
dim(Trump_primaries)
dim(Trump_election)
dim(Hillary_primaries)
dim(Hillary_election)

# Storing Alpha value in object x
x <- 0.05

# Trump (paired) t-test ------------------------------------------------------------------------

# Variance
var(Trump_primaries, Trump_election)

# Plotting Trump's primary and election results
plot(Trump_primaries)
plot(Trump_election)

# Subtracting Trumps election results from his primary - storing values in td
td <- as.numeric(gsub('%','',Trump_primaries[,"Donald.Trump"])) - as.numeric(gsub('%','',Trump_election[,"Donald.Trump"]))

# Retrieving td to the power of 2  - storing values in tdsq
tdsq <- td^2

# Calculating the sum of td and tdsq
std <- sum(td)
stdsq <- sum(tdsq)

# Finding N of tdsq
tn <- NROW(tdsq) # The NROW() function is being used instead of nrow() because the object is a vectoer

# Getting Degree of freedom | Subtracting 1 from n - storing value in tn1
tdf <- tn - 1

# Multiplying N by the sum of tds | subtracting std to the power of 2 - storing result in object
tcal1 <- (tn * stdsq) - (std)^2

# Dividing the previous result to N-1
tcal2 <- tcal1 / tdf

# Getting the Square Root of the last result
tcal2_sqrt <- sqrt(tcal2)

# Dividing the sum of td with previous result and storing the value in object 
trump_tstat <- std / tcal2_sqrt

# Rounding the result
round(trump_tstat)
ceiling(trump_tstat)

# R t-test
t.test(Trump_primaries, Trump_election)

# Correlation result
cor.test(Trump_primaries[,"Donald.Trump"], Trump_election[,"Donald.Trump"])

# Hillary (paired) t-test ------------------------------------------------------------------------

# Variance
var(Hillary_primaries, Hillary_election)

# Plotting Hillary's primary and election results
plot(Hillary_primaries)
plot(Hillary_election)

# Subtracting Hillarys election results from her primary - storing values in hd
hd <- as.numeric(gsub('%','',Hillary_primaries[,"Hillary.Clinton"])) - as.numeric(gsub('%','',Hillary_election[,"Hillary.Clinton"]))

# Retrieving the hd to the power of 2 - storing values in hdsq
hdsq <- hd^2

# Calculating the sum of hd and hdsq
shd <- sum(hd)
shdsq <- sum(hdsq)

# Finding N of tdsq
hn <- NROW(hdsq) # The NROW() function is being used instead of nrow() because the object is a vectoer

# Getting Degree of freedom | Subtracting 1 from n - storing value in hn1
hdf <- hn - 1

# Multiplying N by the sum of hds | subtracting shd to the power of 2 - storing result in object
hcal1 <- (hn * shdsq) - (shd)^2

# Dividing the previous result to N-1
hcal2 <- hcal1 / hdf

# Getting the Square Root of the last result
hcal2_sqrt <- sqrt(hcal2)

# Dividing the sum of hd with previous result and storing the value in object 
hillary_tstat <- shd / hcal2_sqrt

# Rounding the result
round(hillary_tstat)
ceiling(hillary_tstat)

# R t-test
t.test(Hillary_primaries, Hillary_election)

# Correlation result
cor.test(Hillary_primaries[,"Hillary.Clinton"], Hillary_election[,"Hillary.Clinton"])