## File: centrallimit.R
## Author: John Rothfels (rothfels)
## Description: Central Limit Theorem
## ----------------------------------

## Consider I.I.D. random variables X = X1, X2, ... where Xi has
## distribution F with E[Xi] = mu and Var(Xi) = sigma^2

## Then (sum(X) - mu) / (sigma * sqrt(n)) -> N(0, 1) as n -> Inf, where
## n = length(X).

## More intuitively, let xbar = mean(X), then xbar ~ N(mu, sigma^2 / n)
## as n -> Inf

## From the example shown in lecture, start with 150 midterm scores,
## X1, X2, ..., X150. E[Xi] = 78.0, Var(Xi) = 601.2
##
## We create 30 distoint samples of size n = 5, so Y1 = {X1, X2, ..., X5},
## Y2 = {X6, X7, ..., X10}, Yi = {X5i-4, X5i-2, ..., X5i}.

## How is Xi distributed? We don't know. But does it matter?

## Let's generate 150 midterm scores. Max score = 100.

y <- lapply(1:30, function(i) rbinom(5, 100, .8))
ybar <- sapply(y, function(i) mean(i))
ybarbar <- mean(ybar)
var(ybar)                # compare to 100 * .8 * (1 - .8) / 5
hist(ybar)

## Let's see this with 15000 midterm scores.

y <- lapply(1:3000, function(i) rbinom(5, 100, .8))
ybar <- sapply(y, function(i) mean(i))
ybarbar <- mean(ybar)
var(ybar)
hist(ybar)

## What does this all mean? Think about it this way:
## 15000 is the number of people that take an AP test and y is their scores.
##
## For a random subset of 5 people (i.e. a very small classroom), what is
## the probability that they will have a class AP average significantly
## above the mean? Not that small, because the variance of the distribution
## of ybar is reasonably large.
##
## For a random subset of 50 people (i.e. a normal sized classroom), what
## is the probability that they will have a class AP average significantly
## above the mean? Much smaller.

## Let's do a strange example that demonstrates the power of the central
## limit theorem.

## We assumed that student scores on an exam are binomially distributed.
## What if it were something completely different?

GenerateMidtermScores <- function(n) {
  ## Generates n random midterm scores from an unknown distribution.

  options <- c(function() rnorm(1 ,mean = 80, sd = 9),
               function() runif(1, min = 30, max = 100),
               function() rpois(1, 60),
               function() rbinom(1, 100, .6))

  sapply(1:n, function(i) {
    options[[sample(1:4, 1)]]()
  })
}

y <- lapply(1:1500, function(i) GenerateMidtermScores(5))
ybar <- sapply(y, function(i) mean(i))
mean(unlist(y))
mean(ybar)
hist(ybar)

plot(density(unlist(y)))
plot(density(ybar))

## The following plots graphically show how "normal" a sample is. The more
## straight the line, the more normal the distribution.
qqnorm(ybar)
qqnorm(unlist(y))


## We can easilly predict the effect of sample size on the results we get
## from the central limit theorem.

y <- lapply(1:10000, function(i) runif(2))
ybar <- sapply(y, function(i) mean(i))
hist(ybar, freq = FALSE, xlim = range(0, 1))

y <- lapply(1:10000, function(i) runif(4))
ybar <- sapply(y, function(i) mean(i))
hist(ybar, freq = FALSE, xlim = range(0, 1))

y <- lapply(1:10000, function(i) runif(8))
ybar <- sapply(y, function(i) mean(i))
hist(ybar, freq = FALSE, xlim = range(0, 1))

y <- lapply(1:10000, function(i) runif(16))
ybar <- sapply(y, function(i) mean(i))
hist(ybar, freq = FALSE, xlim = range(0, 1))

y <- lapply(1:10000, function(i) runif(32))
ybar <- sapply(y, function(i) mean(i))
hist(ybar, freq = FALSE, xlim = range(0, 1))

y <- lapply(1:10000, function(i) runif(64))
ybar <- sapply(y, function(i) mean(i))
hist(ybar, freq = FALSE, xlim = range(0, 1))



## If X is a Poisson variable with parameter lambda, and
## Z = (X - lambda) / sqrt(lambda), then Z is approximately standard normal,
## and the approximation improves as lambda gets large.

## Can we get a visual aid for how "normal" a random variable is? It will
## help to know the definition of a "quantile".

pnorm(2)           # X ~ N(0,1), P(X < 2) = 0.9772499
qnorm(.9772499)

## So a n% "quantile" is the value at which the probability that a random
## variable is less than the value is n%. The 50% quantile is known as the
## median.

## One purpose of calculating the empirical cumulative distribution function
## if to see whether data can be assumed normally distributed. For a better
## assessment, you might plot the kth smallest observation against the
## expected value of the kth smallest observation out of n in a standard
## normal distribution. The point is that in this way you would expect to
## obtain a straight line if data come from a normal distribution with any
## mean and standard deviation. Creating such a plot is slightly complicated,
## but R has a built in function to do it for you. :)

qqnorm(rnorm(100))
qqnorm(rnorm(1000))
qqnorm(rnorm(1000, mean = 10, sd = 1000))

qqnorm(runif(1000))
qqnorm(rexp(1000))

## Didn't we say earlier that binomial was normal-ish?

qqnorm(rbinom(1000, 100, .5))

# So where does this get us?

z <- (rpois(1000, 10) - 10) / sqrt(10)
qqnorm(z)

z <- (rpois(1000, 200) - 200) / sqrt(200)
qqnorm(z)

