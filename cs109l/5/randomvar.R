## File: randomvar.R
## Author: John Rothfels (rothfels)
## Description: Random Variables & Binomial Distribution
## -----------------------------------------------------

## R doesn't require you to write your own functions to simulate random
## variables. These functions are built into the language. However, defining
## ways to simulate random variables and sample from distributions will help
## you master an understanding of the behavior of the distribution.

## Let's start by looking at the random uniform variable.
## runif - simulates a random uniform variable: X ~ Unif(a, b)
##         (i.e. a real value between a and b)
## Syntax: runif(n, min = a, max = b)

runif(1)

## The behavior of runif is much the same as rand() from C++.
## What happens if we make the following call on different computers, or even
## the same call multiple times on the same computer?

runif(5)
runif(5)
runif(5)

## The default values for 'a' and 'b' are 0 and 1, respectively. We can modify
## these as needed.

runif(100, -5, 5)




## Using runif() to simulate Bernoulli trials
## ------------------------------------------

## Consider a student who guesses on a multiple choice test question
## which has five options. The student may guess correctly with probability
## 0.2 and incorrectly with probability 0.8.

## Suppose we want to simulate how well such a student would do on a 20
## question multiple choice test.

guesses <- runif(20)
correct.answers <- guesses < 0.2
correct.answers
sum(correct.answers)
mean(correct.answers)              # E[# correct answers] = 20 * 0.2




## Using runif() to simulate Binomial random variables
## ---------------------------------------------------

## We want to write an R function which simulates a "binomial random variable"
## with n = 25 and p = 0.4.

## This is a sum of 25 independent Bernoulli random variables, each of which
## has probability of success 0.4.

## By generating a large number of these binomial random variables, we can
## estimate the mean and variance of such a binomial random variable (i.e.
## of the "binomial distrubution") and compare with the theoretical values:
## n * p and n * p * (1 - p, respectively)


random.binomial <- function(n, size, p) {
  ## Simulates 'n' binomial random variables, each of which is the sum
  ## of 'size' Bernoulli trials, each of which has probability of success
  ## 'p'.

  ## Note: 'replicate' is a wrapper for 'sapply'. The code below is identical
  ## (even in its internal representation) to the following:
  ##   sapply(1:n, function(i) sum(runif(size) < p))
  return(replicate(n, sum(runif(size) < p)))
}

x <- random.binomial(100, 25, .4)
x
mean(x)
var(x)



## Let X denote the sum of m independent Bernoulli random variables,
## each having probability of success 'p'. X is called a binomial random
## variable. It represents the number of "successes" in m Bernoulli trials.

## A binomial random variable can take values in the set {0, 1, 2, ..., m}.
## The probability of a binomial random variable X taking on any one of
## these values is governed by the binomial distribution:

## P(X = x) = choose(m, x) * (p^x) * ((1 - p) ^ (m - x))

## These probabilities can be computed using the dbinom() function.

## Syntax: dbinom(x, size, prob)

## Here, 'size' and 'prob' are the binomial parameters 'm' and 'p', while 'x'
## denotes the number of "successes."
## The output from this function is the value of P(X = x).

dbinom(x = 4, size = 6, prob = .5)  # P(four heads in six tosses of fair coin)
dbinom(c(1, 3, 5), 6, .5)

## Cumulative probabilities of the form P(X <= x) can be computed using
## pbinom(); this function takes the same arguments as dbinom().

pbinom(4, 6, .5)
sum(dbinom(0:4, 6, .5))

1 - pbinom(4, 6, .5)                # P(X >= 5)

## The function qbinom() gives the quantiles for the binomial distribution.
## The 89th percentile of the distribution of X (as defined above) is:

qbinom(.89, 6, .5)

qbinom(.9, 200, .3)             # 68
pbinom(67, 200, .3)             # .8757949
pbinom(68, 200, .3)             # .9040488


## rbinom() can be used to generate binomial pseudorandom numbers.

## Syntax: rbinom(n, size, prob)

rbinom(50, 6, .5)

## The expected value (or mean) of a binomial random variable is m * p and
## the variance is m * p * (1-p). How does our random number generation fare?

mean(rbinom(10, 6, .5))
mean(rbinom(100, 6, .5))
mean(rbinom(1000, 6, .5))
mean(rbinom(10000, 6, .5))

var(rbinom(10000, 6, .5))

## Suppose 10% of the code produced by a computer science student is buggy,
## and suppose 150 lines of code are written by that student each hour.
## Each line of code is independent of all other lines of code. At Stanford,
## a computer science student is judged to be "out of control" when more than
## 30 buggy lines of code are produced in any single hour. Simulate the
## number of lines of buggy code produced by the student for each hour over
## a 24-hour coding extravaganza, and determine if the student was out of
## control at any point in these 24-hours.

buggy.lines <- rbinom(24, 150, .1)
buggy.lines
any(buggy.lines > 30)



rand.binom <- rbinom(10000, 20, .3)
mean(rand.binom <= 5)                  # ~ P(X <= 5)
mean(rand.binom == 5)                  # ~ P(X == 5)


## Thought question: after the mapping, what (in English) is the value
## of sum(mystery)?
## Answer: E[rand.binom]

mystery <- 0:20
mystery <- sapply(mystery, function(i) i * mean(rand.binom == i))
sum(mystery)

mean(rand.binom)

mean(rand.binom + 3)
3 + mean(rand.binom)

mean(3 * rand.binom)
3 * mean(rand.binom)

var(rand.binom + 3)
var(rand.binom)

var(3 * rand.binom)
9 * var(rand.binom)
