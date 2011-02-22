## File: ttest.R
## Author: John Rothfels (rothfels)
## Description: T-Test
## -------------------

## In probability and statistics, the t-distribution is a continuous probability
## distribution that arises in the problem of estimating the mean of a normally
## distributed population when the sample size is small. It is the basis of the
## popular t-test for the statistical significance of the difference between two
## sample means, and for confidence intervals for the difference between two
## population means.

curve(dnorm(x), from = -4, to = 4)

sapply(1:10, function(df) {
  curve(dt(x, df),from = -4, to = 4, col = 'blue', add = TRUE)
  Sys.sleep(1)
})

## From the code above, you can see that the t distribution approaches the
## normal distribution as df ("degrees of freedom") approaches infinity.
## This roughly corresponds to the fact that an empirical sampling from
## the standard normal distribution should look more normal as more points
## are sampled, so 'df' corresponds (intuitively) to the number of points
## in an empirical sample.

## Among the most frequently used t-tests are:

## 1) a one sample location test of whether the mean of a normally distributed
##    population has a value specified in a null hypothesis
## 2) a two sample location test of the null hypothesis that the means of two
##    normally distributed populations are equal

## Some vocabulary:
##   null hypothesis - a hypothesis (within the frequentist context of
##     statistical hypothesis testing) that might be falsified using a test of
##     observed data
##   p value - the probability of obtaining a test statistic at least as extreme
##     as the one that was actually observed, assuming that the null hypothesis
##     is true (i.e. the conditional probability of test statistic given null
##     hypothesis)
##     NOTE: the lower the p value, the less likely the results if the null
##     hypothesis is true, and consequently the more "significant" the result
##     is, in the sense of statistical significance.
##   statistically significant - a result that is unlikely to have occurred by
##     chance

## One often rejects a null hypothesis if the p value is less than 0.05 or 0.01
## corresponding to a 5% or 1% chance respectively of an outome at least that
## extreme, given the null hypothesis.

t.test(1:10)
t.test(rnorm(1))          # t-test can't be performed over one data point
t.test(rnorm(10))
t.test(rnorm(100))

replicate(10, t.test(rnorm(100)), simplify = FALSE)
t.test(rnorm(1000))

## Notice for each of the t-tests that df is set (by default) to the number
## of points in the empirical sample (less one). Remember that the higher
## the value of df, the more "normal" the t distribution looks. For the t-test,
## a higher value of df means that the data needs to look much more like the
## normal distribution for the null hypothesis NOT to be rejected. This allows
## t-tests to be run with (roughly) equal efficiency on small and large samples
## of data.

## A t test can also compare the means of two groups. For example, compare
## whether systolic blood pressure differs between a control and treated group,
## between men and women, or any other two groups.

t.test(1:10, 7:20)
t.test(1:10, c(7:20, 200))

?sleep
t.test(extra ~ group, data = sleep)

## The t tests are fairly robust against departures from the normal distribution
## especially in larger samples, but sometimes you wish to avoid making that
## assumption. To this end, the distribution-free-methods are convenient.
## These are generally obtained by replacing data with corresponding order
## statistics.

## Here is an example concerning the daily energy intake in kJ for 11 women:

daily.intake <- c(5260, 5470, 5640, 6180, 6390, 6515, 6805,
                  7515, 7515, 8230, 8770)
mean(daily.intake)
sd(daily.intake)
quantile(daily.intake)

wilcox.test(daily.intake, mu = 7725)

library(ISwR)
data(energy)
energy

## Note by default that t-tests do not assume the variances of each sample
## to be equal. You can do this by an optional parameter.

t.test(expend ~ stature, data = energy)
t.test(expend ~ stature, data = energy, var.equal = TRUE)

## Although it is possible in R to perform the two-sample t test without the
## assumption that the variances are the same, you amy still be interested
## in testing that assumption, and R provides the var.test function for
## that purpose.

var.test(expend ~ stature, data = energy)


## When your data contains two measurements on the same experimental unit,
## paired tests are used. The theory is essentially based on taking differences
## and thus reducing the problem to that of a one-sample test.

data(intake)
?intake
head(intake)

## Notice that these both give the same overall result.
t.test(intake$pre, intake$post, paired = TRUE)
t.test(intake$post - intake$pre)

## This test is seriously inappropriate to analyze the data without taking the
## pairing into account.
t.test(intake$pre, intake$post)


## Appendix: When to use T Tests
## -----------------------------

## Don't confuse t tests with correlation and regression. The t test compares
## one variable (perhaps blood pressure) between two groups. Use correlation
## and regression to see how two variables (perhaps blood pressure and heart
## rate) vary together. Also don't confuse t tests with ANOVA. The t tests
## (and related nonparametric tests) compare exactly two groups.
## ANOVA (and related nonparametric tests) compare three or more groups.
## Finally, don't confuse a t test with analyses of a contingency table
## (Fishers or chi-square test). Use a t test to compare a continuous variable
## (e.g. blood pressure, weight, or enzyme activity). Use a contingency table
## to compare categorical variables (e.g. pass vs. fail, viable vs. not viable).

