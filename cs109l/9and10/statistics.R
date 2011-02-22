## File: table.R
## Author: John Rothfels (rothfels)
## Description: Basic Statistical Analysis in R
## --------------------------------------------

## Descriptive Statistics:
## R provides a wide range of functions for obtaining summary statistics.
## One method of obtaining descriptive statistics is to use the sapply()
## function with a specified summary statistic.

library(ISwR)
data(juul)
?juul

head(juul)
tail(juul)

## Get means for variables in the dataframe 'mydata' excluding missing values.
sapply(juul, mean, na.rm = TRUE)
sapply(juul, function(i) sum(is.na(i)))

## Possible functions used in sapply include 'mean', 'sd', 'var', 'min', 'max',
## 'med', 'range', and 'quantile'. There are also numerous R functions designed
## to provide a range of descriptive statistics at once.

summary(juul)

## Note that the data set has menarche, sex, and tanner coded as numeric
## variables even though they are clearly categorical. This can be mended
## as follows:

juul$sex <- factor(juul$sex, labels = c("M", "F"))
juul$menarche <- factor(juul$menarche, labels = c("No", "Yes"))
juul$tanner <- factor(juul$tanner, labels = c("I", "II", "III", "IV", "V"),
                      ordered = TRUE)
summary(juul)

## We could have also done the above with the 'transform' function.

juul <- transform(juul,
                  sex = factor(sex, labels = c("M","F")),
                  menarche = factor(menarche, labels = c("No","Yes")),
                  tanner = factor(tanner, labels = c("I","II","III","IV","V"),
                                  ordered = TRUE))

## Other packages provide their own summary statistic mechanisms.

library(Hmisc)
describe(juul)

library(pastecs)
stat.desc(juul)

library(psych)
describe(juul)
describe.by(juul, group, ...)

## You can generate frequency tables using the table() function, table of
## proportions using the prop.table() function, and marginal frequencies using
## margin.table().


table(juul$sex)
table(juul$tanner)
mytable <- table(juul$sex, juul$tanner)


margin.table(mytable, 1)  # sex (summed over tanner)
margin.table(mytable, 2)  # tanner (summed over sex)

prop.table(mytable)       # cell percentages
prop.table(mytable, 1)    # row percentages
prop.table(mytable, 2)    # column percentages

## table() can also generate multidimensional tables based on 3 or more
## categorical variables. In this case, use the ftable() function to
## print the results more attractively.

mydata <- data.frame(a = 0:10, b = 100:110, c = 1000:1010)
mytable <- table(mydata)
mytable
ftable(mytable)

table(juul$sex, juul$tanner, juul$menarche)

## Note by default, table() ignores missing values. To include NA as a category
## in counts, include the table option 'exclude = NULL' if the variable is
## a vector. If the variable is a factor you have to create a new factor
## using newfactor <- factor(oldfactor, exclude = NULL).


## The tapply function takes a vector and splits it according to a group
## variable (factor).

tapply(juul$igf1, juul$tanner, mean)
tapply(juul$igf1, juul$tanner, mean, na.rm = TRUE)

tapply(juul$igf1, list(juul$tanner, juul$sex), mean, na.rm = TRUE)

## The functions 'aggregate' and 'by' are variations on the same topic. The
## former is very much like 'tapply' except that it works on an entire data
## frame and presents its results as a data frame. This is useful for
## presenting many variables at once.

aggregate(juul[c("age", "igf1")], juul["sex"], mean, na.rm = TRUE)

## The 'by' function is again similar but different. The difference is that
## the function now takes an entire (sub-) data frame as its argument, so that
## you can for instance summarize the Juul data by sex as follows:

by(juul, juul["sex"], summary)

## For 2-way tables you can use chisq.test(mytable) to test independence of
## the row and column variable. By default, the p-value is calculated from the
## asymptotic chi-squared distribution of the test statistic. Optionally, the
## p-value can be derived via Monte Carlo simultation. Chi-square tests the
## null hypothesis that the two variables are independent.

mytable <- table(juul$sex, juul$age)
chisq.test(mytable)

## You can perform the Chi-square test even on data that is not tabular.
chisq.test(juul$sex, juul$age)

mytable <- table(juul$sex, juul$menarche)
chisq.test(mytable)

chisq.test(juul$sex, juul$igf1)

mytable <- table(juul$sex, cut(juul$igf1, breaks = 10))
chisq.test(mytable)




## Appendix: Proportion Tests
## --------------------------

## Tests of single proportions are generally based on the binomial distribution
## with size parameter N and probability parameter p. For large sample sizes,
## this can be well approximated by a normal distribution with mean Np and
## variance Np(1 - p). We consider an example where 39 of 215 randomly chosen
## patients are observed to have asthma and one wants to test the hypothesis
## that the probability of a "random patient" having asthma is 0.15. This
## can be done using prop.test:

prop.test(39, 215, .15)

## You can also use binom.test to obtain a test in the binomial distribution.

binom.test(39, 215, .15)

## Two test the hypothesis that two proportions are identical, you can
## do a two sample prop.test() as follows:

success <- c(9, 4)
total <- c(12, 13)

prop.test(success, total)

success <- success * 2
total <- total * 2

prop.test(success, total)
