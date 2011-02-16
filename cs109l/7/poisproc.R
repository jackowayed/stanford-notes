## File: poisproc.R
## Author: John Rothfels (rothfels)
## Description: Poisson Process
## ----------------------------

## A Poisson process models random events (such as a customer arrival,
## a request for action from a web server, or the completion of the actions
## requested of a web server) as emanating from a memoryless process.
## That is, the length of the time interval from the current time to the
## occurrence of the next event does not depend upon the time of occurrence
## of the last event. In the Poisson probability distribution, the observer
## records the number of events that occur in a time interval of fixed length.
## In the (negative) exponential probability distribution, the observer
## records the length of the time inteval between consecutive events.
## In both, the underlying physical process is memoryless.

## More formally, the Poisson Process is a collection { N(t) : t >= 0 } of
## random variables, where N(t) is the number of events that have occured up
## to time t (starting from time 0). The number of events between time a and
## time b is given as N(b) - N(a) and has a Poisson distribution. Each
## realization of the process { N(t) } is a non-negative integer-valued step
## function that is non-decreasing, but for intuitive purposes it is usually
## easier to think of it as a point pattern on [0, inf], the points in time
## where the step function jumps, i.e. the points in time where an event
## occurs.

## We assume the following properties:
## 1) N(0) = 0
## 2) Independent increments (the number of occurrences counted in disjoint
##    intervals are independent from each other)
## 3) Stationary increments (the probability distribution of the number of
##    occurrences counted in any time interval only depends on the length of
##    the interval)
## 4) No counted occurrences are simultaneous

## The consequences of this definition include:
## 1) The probability distribution of N(t) is Poisson
## 2) The probability distribution of the waiting time until the next
##    occurrence is a Exponential

## The most simple Poisson process is called "homogeneous," and is
## characterized by a rate parameter 'lambda,' the average number of events
## per unit time.

## X = P(t + dt) - P(t) = number of events in dt time ~ Poi(lambda * dt)

## How can we simulate this? Pick a large number T (say, 1000 seconds).
## Suppose that we have, on average, .1 event per second (lambda = 100).

N <- rpois(1, 1000 * .1)
points <- runif(N, 0, 1000)
points <- sort(points)
plot(points, 1:length(points), type = 's')

## Can we calculate the mean time interval between events occuring?
## In seconds, with an average of .1 per second, this should be 10 seconds.
differences <- points[-1] - points[-length(points)]
mean(differences)
plot(density(differences))

## Does this look familiar?

## Let's try the same thing but with an average of 1 person per second
## over a time interval of 100000 seconds.
points <- runif(N, 0, 100000)
points <- sort(points)
differences <- points[-1] - points[-length(points)]
plot(density(differences))
curve(dexp(x, rate = 1), from = 0, to = 10, col = 'red', add = TRUE)


## Let Tk be the time of the kth arrival, for k = 1,2,3,...

## Clearly the number of arrivals before some fixed time t is less than k
## if and only if the waiting time until the kth arrival is more than t.
## So the event N(t) < k occurs if and only if Tk > t. Consequently, the
## probabilities of these events are the same:

## P(Tk > t) = P(N(t) < k)

## In particular, consider the waiting time until the first arrival.
## Clearly that time is more than t if and only if the number of arrivals
## before time t is 0.

## P(T1 > t) = P(N(t) = 0) = P(N(t) - N(0) = 0)
##           = exp(-lambda*t)(lambda*t)^0/0! = exp(-lambda*t)
## But this is P(X > t) for X ~ Exp(lambda) = 1 - pexp(t, lambda)

## Alternatively....

X <- rexp(100, .1)
points <- cumsum(X)
mean(points[-1] - points[-length(points)])


## Simulating a Queue:
## -------------------
## One person at the front of the queue is served at each (integer) time,
## after which some number of new people arrive, with the number being
## Poisson distributed with the given mean. The queue can hold a maximum of
## 'max' people; any beyond that have to go away (and never return). The queue
## is simulated (starting with an empty queue) for the given number of steps.
## The result returned is a list with an element called $length that is a
## vector of size steps containing the length of the queue after each step,
## and a element called $away that is a vector of size 'steps' containing the
## number of people who went away because the queue was full during each
## time step.

SimulateQueue <- function(steps, mean.arrive, mean.serve, max = NULL,
                          remove = FALSE) {
  ## Simulates a queue run over a specified number of timesteps.
  ## Args:
  ##   steps - number of intervals to run the queue over
  ##   mean.arrive - the average number of people that arrive at each interval
  ##   mean.serve - the average number of people that are served each interval
  ##   max - the maximum number of people that can be in the queue
  ##   remove - if TRUE, then the queue serves people

  ## Allocate space for vectors that will contain results
  length <- rep(0, steps)    # length of the queue at each timestep
  away <- rep(0, steps)      # number of people sent away at each timestep

  ## Set the length of the queue to zero at start
  qlen <- 0

  ## Loop for the requested number of steps
  for (t in 1:steps) {

    ## Service people from the queue.
    if (remove) {
      qlen <- max(0, qlen - rpois(1, mean.serve))
    }

    ## Increase the number in the queue by the number of new arrivals
    qlen <- qlen + rpois(1, mean.arrive)

    if (!is.null(max) && qlen > max) {
      away[t] <- qlen - max
      qlen <- max
    }

    ## Record how long the queue is after this step.
    length[t] <- qlen
  }

  if (!is.null(max)) return(list(length = length, away = away))
  return(list(length = length))
}

q <- SimulateQueue(1000, .1)
1000 / max(q$length)

q <- SimulateQueue(10000, .1)
10000 / max(q$length)

q <- SimulateQueue(100000, mean.arrive = 2, mean.serve = 1, remove = TRUE)
100000 / max(q$length)

q <- SimulateQueue(100, mean.arrive = 1, mean.serve = .5, remove = TRUE, max = 5)
q

q <- SimulateQueue(100000, mean.arrive = 1, mean.serve = .5,
                   remove = TRUE, max = 5)

## Q: What distribution does q$away most closely follow?





