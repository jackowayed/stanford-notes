## File: exponential.R
## Author: John Rothfels (rothfels)
## Description: Exponential Distribution
## -------------------------------------

## Exponential random variables are used as simple models for such things
## as failure times of mechanical or electronic components, or for the time
## it takes a server to complete service to a customer. The exponential
## distribution is characterized by a constant failure rate, denoted by
## lambda. X has an exponential distribution with rate lambda > 0 if
## P(X <= x) = 1 - exp(-lambda*x).
##
## It is easiest to interpret the exponential distribution as follows:
##   If lambda is the number of "things" which happen during a time interval,
##   then X ~ Exp(lambda) models the amount of time it takes a single "thing"
##   to happen, where this amount of time is given as a fraction of the
##   time interval.
## Do you see now why E[X] = 1/lambda? This is because, on average, lambda
## "things" per time interval. This comes from the definition of lambda.

## As an example, suppose the service time at a bank teller can be modeled as
## an exponential random variable with a rate of 3 per minute. In other words,
## a bank teller can service on average 3 people per minute. Then the
## probability of a customer being served in less than 1 minute is:

pexp(1, rate = 3)
rexp(1, rate = 3)    ## random service time for one customer

## If a person shows up at the bank at time t = 0 and there are 30 people
## waiting in line and a single teller who services at a rate of 3 people per
## minute, what is the expected wait time of the person who just showed up?
## Clearly, 10. You can do this in your head. It's an intuitive answer.
## But what do you think is the probability that the person will have to
## wait less than 10 minutes? If we model each person as an independent event,
## then it's P(sum 30 service times at 3 per minute < 10).

mean(replicate(10000, sum(rexp(30, rate = 3)) < 10))


## A bank has a single teller who is facing a queue of 10 customers.
## The time for each customer to be served is exponentially distributed with
## rate 3 per minute. We can simulate the service times (in minutes) for the
## 10 customers.

servicetimes <- rexp(10, rate = 3)
servicetimes
sum(servicetimes)      # total time it takes (in minutes) to complete service

## A simple electronic device consists of two components that have failure
## times which may be modeled as independent exponential random variables.
## The first component has a mean time to failure of 3 months, and the second
## has a mean time to failure of 6 months. The electronic device will fail
## when either of the components fails. Use simulation to estimate the mean
## and variance of the time to failure for the device. What if the device only
## fails after BOTH components fail?

r1 <- rexp(100000, rate = 1/3)
r2 <- rexp(100000, rate = 1/6)

index <- (r2 - r1) > 0
r.min <- c(r1[index], r2[!index])
mean(r.min)
var(r.min)

r.max <- c(r1[!index], r2[index])
mean(r.max)
var(r.max)
