## File: distributions.R
## Author: John Rothfels (rothfels)
## Description: Distributions in R
## -------------------------------


## We'll start with a brief review from last week:

dbinom(x = 4, size = 6, prob = .5)  # P(four heads in six tosses of fair coin)
dbinom(c(1, 3, 5), 6, .5)

## Cumulative probabilities of the form P(X <= x) can be computed using
## pbinom(); this function takes the same arguments as dbinom().

pbinom(4, 6, .5)
sum(dbinom(0:4, 6, .5))

1 - pbinom(4, 6, .5)         # P(X >= 5)


## Poisson random variables arise in a number of different ways. They are
## often used as a crude model for count data. Examples of count data are
## the numbers of earthquakes in a region in a given year, or the number of
## individuals who arrive at a bank teller in a given hour. The limit comes
## from dividing the time period into n independent intervals, on which the
## count is either 0 or 1. The Poisson random variable is the total count.

## Syntax: dpois(x, lambda)

## Here, 'lambda' is the Poisson rate parameter, while x is the number of
## events. The output from the function is the value of P(X = x) for
## X ~ Poi(lambda).

## Suppose that an ATM receives an average number of .5 arrivals per minute.
## Q: P(3 people in a minute)?

dpois(3, .5)

## Suppose that an ATM machine receives on average 30 arrivals each hour.
## Q: P(3 people in a minute)
## Q: P(60 in an hour)

dpois(3, .5)
dpois(60, 30)

## What's wrong with this?
dpois(1, .5) ^ 60


## Cumulative probabilities of the form P(X <= x) can be calculated using
## ppois(). We can generate Poisson random numbers using the rpois() function.

ppois(3, .5)
rpois(10, .5)

mean(rpois(10000, 7.2))
var(rpois(10000, 7.2))



## Normal distributions have symmetric, bell-shaped density curves that are
## described by two parameters: the mean, and the standard deviation. The two
## points of a normal curve that are the steepest -- at the "shoulders" of the
## curve -- are precisely one standard deviation above and below the mean.

pnorm(100, mean = 145, sd = 22)         # P(X < 100)
1 - pnorm(100, 145, 22)                 # P(X > 100)

pnorm(150, 145, 22) - pnorm(120, 145, 22)


## Q: If X ~ N(0, 1) what is the approximate probability that x = 0?
## A: When computing P(x = 0), we can compute P(0 - e/2 < x < 0 + e/2)
##    as an approximation of e*dnorm(0).

pnorm(.1) - pnorm(-.1)
.2 * dnorm(0)

pnorm(.05) - pnorm(-.05)
.1 * dnorm(0)

## Simulate x from the standard normal distribution, conditional on the event
## that 0 < x < 3.
x <- rnorm(100000)
x <- x[(0 < x) & (x < 3)]
hist(x, probability = TRUE)




## Comparing Distributions
## -----------------------

## Now let's get a visual feel for some of these distributions, and their
## relationship to one another. We'll be discussing this in more detail
## next week after you have a chance to see some more distributions in 109.

hist(runif(1000))
hist(rnorm(1000), freq = FALSE)
curve(dnorm, add = TRUE)

curve(pnorm)
curve(punif, from = 0, to = 1)

## The "empirical cumulative density function" (ecdf) can be used
## to visualize an assortment of data points. Each distribution has a
## unique ecdf signature

plot(ecdf(runif(10000)))
plot(ecdf(rnorm(10000)))
plot(ecdf(rgeom(10000, .2)))
plot(ecdf(runif(10000) + rnorm(10000) + rpois(10000, 3)))

plot(1:10, pbinom(1:10, size = 10, prob = .5), type = "l")

## Can you see the similarity between binomial and normal distributions?

curve(pnorm(x, 10 * .5, sqrt(10 *.5 *.5)), add = TRUE, col = "red")

## What about Poisson?

lines(1:10, ppois(1:10, 10 * .5), col = "green")

## Make sure you understand these relationships.

plot(x <- sort(rnorm(5000)), type = "l")
abline(v = 2500)
abline(h = x[2500], col = "red")


plot(x <- ecdf(rnorm(5000)))
curve(pnorm(x), add = TRUE, col = "red")

plot(x <- ecdf(rpois(50, 5)))
plot(x <- ecdf(rpois(500, 5)))
plot(x <- ecdf(rpois(5000, 5)))


## If X ~ Bin(n, p) then X can be approximated by Poi(lambda = n*p) and this
## approximation gets better as n->inf and p->0.

x <- 0:10
plot(x, dbinom(x, 10, .3), type = "h", lwd = 15, col = "blue")
lines(x,dbinom(x, 100, .03), type = "h", lwd = 10, col = "yellow")
lines(x, dpois(x, 3), type = "h", lwd = 5, col = "red")


## Let's zoom out and see what happens.

bin.versus.poi <- function(n, p, type) {
  x <- 0:n
  y.bin <- dbinom(x, n, p)
  y.poi <- dpois(x, n*p)
  plot(x, y.bin, type = type, lwd = 3, col = 'blue')
  lines(x, y.poi, type = type, lwd = 2, col = 'yellow')
}

bin.versus.poi(20, .2, type = 'l')
bin.versus.poi(40, .1, type = 'l')
bin.versus.poi(80, .05, type = 'l')

bin.versus.poi(500, .5, type = 'l')
bin.versus.poi(1000, .25, type = 'l')
bin.versus.poi(2000, .125, type = 'l')

bin.versus.poi.animation <- function(n, p, type, multiplier = 5, frames = 5,
                                     sleep = 3, zoom.out = FALSE) {
  x.max <- n
  for (i in 1:frames) {
    x <- 0:x.max
    y.bin <- dbinom(x, n, p)
    y.poi <- dpois(x, n*p)
    plot(x, y.bin, type = type, lwd = 3, col = 'blue')
    lines(x, y.poi, type = type, lwd = 2, col = 'yellow')
    if (zoom.out) x.max <- x.max*multiplier
    n <- n*multiplier
    p <- p/multiplier
    Sys.sleep(sleep)
  }
}

bin.versus.poi.animation(250, .5, 'l')
bin.versus.poi.animation(250, .5, 'l', zoom = TRUE)

bin.poi.norm <- function(n, p) {
  x <- 0:n
  y.bin <- dbinom(x, n, p)
  y.poi <- dpois(x, n*p)
  plot(x, y.bin, type = 'l', lwd = 5, col = 'blue')
  curve(dnorm(x, n*p, sqrt(n*p*(1-p))), lwd = 2, col = 'yellow', add = TRUE)
  lines(x, y.poi, type = 'l', lwd = 2, col = 'green')
}

bin.poi.norm(100, .5)
bin.poi.norm(100, .25)
bin.poi.norm(100, .125)


## I encourage you to go play with some of the other distributions, and take a
## look at them graphically.
