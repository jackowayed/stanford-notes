## File: em.R
## Author: John Rothfels (rothfels)
## Description: Expectation Maximization Algorithm
## -----------------------------------------------

## Suppose that the time from when a machine is manufactured to when it fails
## is exponentially distributed (a common, though simplistic, assumption).
## However, suppose that some machines have a manufacturing defect that causes
## them to be more likely to fail early than machines that don't have the
## defect. Let the probability that a machine has the defect be p, the mean
## time to failure for machines with the defect be m1, and the mean time to
## failure for machines without the defect be m2. The probability density for
## the time to failure will then be the following mixture denity:
##
##   p*(1/m1)*exp(-x/m1) + (1-p)*(1/m2)*exp(-x/m2)
##
## Suppose that you have a number of independent observations of times to
## failure for machines, and that you wish to find the maximum likelihood
## estimates for p, m1, and m2. Find these estimates using the EM algorithm,
## with the unobserved data being the indicators of whether or not each
## machine is defective.

EM <- function(x, m1 = mean(x) * 0.9, m2 = mean(x) * 1.1,
               p = 0.5, n = 20, debug = 0) {
  ## Args:
  ##   x - the vector of data points
  ##   m1, m2 - the initial values for the means of the two components
  ##   p - the initial value for the probability of a data point coming from
  ##       the first component
  ##   n - the number of iterations of EM to do
  ##   debug - debug option. If zero, no debug information is printed. If
  ##           greater than zero, debug information is printed at intervals
  ##           given by its value.
  ## Returns:
  ##   A list of parameter estimates for [[1]] the mean time to failure of
  ##   defective machines, [[2]] the mean time to failure of good machines,
  ##   and [[3]] the probability that a machine is defective.

  if (debug != 0) {
    cat(0, m1, m2, p, LL(x, m1, m2, p), "\n")
  }

  for (i in 1:n) {
    odds <- (p * dexp(x, 1/m1)) / ((1-p) * dexp(x, 1/m2))
    r <- odds / (1 + odds)

    p <- mean(r)
    m1 <- sum(r*x) / sum(r)
    m2 <- sum((1-r)*x) / sum(1-r)

    if (debug != 0 && i %% debug == 0) {
    	cat(i, m1, m2, p, LL(x ,m1, m2, p), "\n")
    }
  }

  return(list(m1 = m1, m2 = m2, p = p))
}


## LOG LIKELIHOOD FUNCTION FOR THE EXPONENTIAL MIXTURE. Not needed to do EM,
## but useful for debugging.
LL <- function(x, m1, m2, p) {
  return(sum(log(p*dexp(x, 1/m1) + (1-p)*dexp(x, 1/m2))))
}


# FUNCTION TO GENERATE TEST DATA FROM AN EXPONENTIAL MIXTURE.
Gen <- function(m1, m2, p, N) {
  w <- runif(N) < p

  x1 <- rexp(N, 1/m1)
  x2 <- rexp(N, 1/m2)

  return(w*x1 + (1-w)*x2)
}


x <- Gen(10, 12, .4, 1000)
EM(x, debug = 1)

x <- Gen(5, 12, .1, 1000)
EM(x, debug = 1)

x <- Gen(5, 12, .1, 10000)
EM(x, n = 1000, debug = 10)
EM(x, n = 10000, debug = 100)
