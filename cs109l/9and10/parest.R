## File: parest.R
## Author: John Rothfels (rothfels)
## Description: Parameter Estimation
## ---------------------------------

## In statistics, we often would like to estimate unknown parameters for known
## distributions. For instance, we may think that the distribution for a
## random variable is normal, but the mean is unknown, or both the mean and
## standard deviation are unknown. From a data set, we can't hope to know
## the exact values of parameters, but the data should give us a good idea
## of what they are. For the mean, we expect that the sample mean or average
## of our data will be a good choice for the true mean, and intuitively, we
## understand that the more data we have the better this estimate should be.

## Consider I.I.D. random variables X1, X2, ..., Xn.
## Xi has distribution F with E[Xi] = mu and Var(Xi) = (sigma)^2

## Let xbar = mean(X) = sum(X) / n, so Var(xbar) = (sigma)^2 / n

x <- replicate(10000, mean(rnorm(10, mean = 3, sd = 3)))
mean(x)         # compare to 3
var(x)          # compare to 9/10

x <- replicate(10000, mean(rnorm(100, mean = 3, sd = 3)))
mean(x)
var(x)          # compare to 9/100

x <- replicate(10000, mean(rnorm(10000, mean = 3, sd = 3)))
mean(x)
var(x)          # compare to 9/10000

## Recall that the sample variance of X = X1, X2, ..., Xn is
## S^2 = sum(((x - mean(x)) ^ 2) / (n - 1))

n <- 10
x <- rnorm(10, mean = 3, sd = 3)
xbar <- mean(x)
sum(((x - xbar) ^ 2) / (n - 1))       # compare to var(x)

## For large n, the 100(1 - alpha)% confidence interval is defined as:
##
## (xbar - z*S / sqrt(n), xbar + z*S / sqrt(n))
##
## Where phi(z) = 1 - (alpha/2)

## How do we compute the z in phi(z)?

pnorm(0)                # P(X < 0) = phi(0)
pnorm(1) - pnorm(-1)	# P(-1 < X < 1)

## At what value z is P(X < z) = val? For the standard normal, this is the
## same as saying phi(z) = val. To answer this question, we use the qnorm
## function.

qnorm(.5)
qnorm(.8)
pnorm(qnorm(.8))

## Let's see an example.
## When alpha = .05, alpha/2 = .025, phi(z) = .975, z = qnorm(.975) = 1.96

## The meaning of the confidence interval is as follows: 100(1 - alpha)% of
## the time that a the confidence interval is computed from a sample, the
## true mean will be in that interval. Let's see this in simulation.

## Suppose we sample from a normal distribution with parameters mean = 2 and
## sd = 4. Let's find the 90% confidence interval and the 95% confidence
## interval.

ConfidenceInterval <- function(n, alpha, mean, sd) {
  ## Computes a 100(1 - alpha)% confidence interval from a sample of normal
  ## variables of size n with parameters mean and sd.

  x <- rnorm(n, mean, sd)    # generate the sample
  xbar <- mean(x)
  S <- sqrt(var(x))
  z <- qnorm(1 - alpha/2)
  c(xbar - z*S / sqrt(n), xbar + z*S / sqrt(n))
}

## For 90% confidence interval:
ConfidenceInterval(10, .1, 2, 4)

## For 95% confidence interval:
ConfidenceInterval(10, .05, 2, 4)


ConfidenceInterval(10, .1, 2, 4)
ConfidenceInterval(10, .1, 2, 4)
ConfidenceInterval(10, .1, 2, 4)
ConfidenceInterval(10, .1, 2, 4)

## What do we notice as the sample size increases?
ConfidenceInterval(100, .1, 2, 4)
ConfidenceInterval(1000, .1, 2, 4)
ConfidenceInterval(10000, .1, 2, 4)

## What about as we boost our confidence?
ConfidenceInterval(100, .01, 2, 4)
ConfidenceInterval(100, .0001, 2, 4)

## What about as we loosen our confidence?
ConfidenceInterval(100, .001, 2, 4)
ConfidenceInterval(100, .5, 2, 4)

## Let's test in simulation to see if the confidence % is obeyed:

mean(sapply(1:10000, function(i) {
  confi <- ConfidenceInterval(100, .1, 2, 4)
  return(confi[1] < 2 && confi[2] > 2)
}))

mean(sapply(1:10000,function(x) {
  confi <- ConfidenceInterval(100, .05, 2, 4)
  return(confi[1] < 2 && confi[2] > 2)
}))

mean(sapply(1:10000,function(x) {
  confi <- ConfidenceInterval(100, .5, 2, 4)
  return(confi[1] < 2 && confi[2] > 2)
}))

## And that's happy times. :)

## Of course, R has this built in functionality as well. We'll look at this
## more in just a little bit.

x <- rnorm(10, mean = 3, sd = 3)
t.test(x)

x <- rnorm(100, mean = 3, sd = 3)
t.test(x)

x <- rnorm(1000, mean = 3, sd = 3)
t.test(x)

## There are other tests in R as well to compute confidence intervals
## for values other than mean, such as the wilcox.test for median:

x <- c(110, 12, 2.5, 98, 1017, 540, 54, 4.3, 150, 432)
wilcox.test(x, conf.int = TRUE)





## Method of Moments
## -----------------

## Recall that the n-th moment of distribution for variable x is m = E[X^n]

## Consider I.I.D. random variables X1, X2, ..., Xn. We can compute the
## sample moments as follows:
##   m1 = mean(X), m2 = mean(X^2), m3 = mean(X^3), etc.

## Method of Moments estimators estimate model parameters by equating
## "true" moments to sample moments. So xbar = mean(X) ~ E[X],
## Var(X) = E[X^2] - (E[X])^2 ~ m2 - (m1)^2 = mean(X^2 - xbar^2)

x <- rnorm(10, 3, 3)
var(x)
mean(x^2) - mean(x)^2

x <- rnorm(100, 3, 3)
var(x)
mean(x^2) - mean(x)^2

x <- rnorm(1000, 3, 3)
var(x)
mean(x^2) - mean(x)^2

## What is the difference between the sample variance and the MOM estimate
## for variance? Consider the following:

x <- 1

## The sample variance is undefined (by dividing by 0). In other words,
## sample variance tells us we know nothing about the variance of the data.
var(x)

## The MOM estimate for variance tells us we have complete certainty about
## the distribution -- there is no variance at all.
mean(x^2) - mean(x)^2

