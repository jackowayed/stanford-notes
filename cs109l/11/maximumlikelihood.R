## File: maximumlikelihood.R
## Author: John Rothfels (rothfels)
## Description: Maximum Likelihood Estimation
## ------------------------------------------

## Consider n I.I.D. random variables X1, X2, ..., Xn.
##
## Xi is a sample from density function f(Xi | theta) and we want to determine
## how "likely" the observed data (x1, x2, ..., xn) is based on density
## f(Xi | theta). We define the Likelihood function as follows:
##   L(theta) = prod(f(X | theta))
## We define the Log-Likelihood function LL(theta) = log(L(theta))
## The Maximum Likelihood Estimator (MLE) of theta is the value of theta
## that maximizes L(theta) or LL(theta)

## Suppose now we wish to find the parameter lambda maximizing the log
## likelihood of Poisson data.

PoissonLL <- function(lambda, x) {
  return(sum(log(exp(-lambda) * lambda^x / factorial(x))))
}

PoissonLLDeriv <- function(lambda, x) {
  return(-length(x) + sum(x) / lambda)
}

PoissonLLDeriv2 <- function(lambda, x) {
  return(-sum(x) / lambda^2)
}

PoissonMLE <- function(x, theta0 = mean(x), n = 10) {
  ## Computes the maximum likelihood estimate of theta for the Poisson
  ## distribution via Newton Raphson iteration.
  ## Args:
  ##   x - data to compute MLE over
  ##   theta0 - initial value for Newton Raphson iteration
  ##   n - number of iterations to perform

  theta <- theta0
  for (i in 1:n) {
    print(theta)
    theta <- theta - PoissonLLDeriv(theta, x) / PoissonLLDeriv2(theta, x)
  }
  return(theta)
}

x <- rpois(100, 5)
mle <- PoissonMLE(x)
mle
PoissonLL(mle, x)
PoissonLL(mle - .5, x)
PoissonLL(mle + 1, x)

mle <- PoissonMLE(x, theta0 = 3)
mle <- PoissonMLE(x, theta0 = 3, n = 3)
mle <- PoissonMLE(x, theta0 = 19)
