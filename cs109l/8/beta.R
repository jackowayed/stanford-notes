## File: beta.R
## Author: John Rothfels (rothfels)
## Description: Beta Distribution
## ------------------------------

## Beta and Bernoulli: flip n + m coins, p = theta ~ Beta(a, b), where
## p = chance of heads.

## To understand the Beta distribution, it should be sufficient to understand
## the following (which includes some technical jargon):

## 1) Let Beta(a, b) be the "prior" distribution. Let theta ~ Beta(a, b).
## 2) By the definition of the distribution, Y ~ Beta(a, b) if the density
##    f(y) = C * y^(a-1) * (1-y)^(b-1) | 0 <= y <= 1
## 3) Beta(1, 1) = Uniform(0, 1)
## 4) Mean of Beta(a, b) is a / (a+b)
## 5) Given the "prior," we oserve D = { m heads, n tails }
## 6) The "likelihood" of this observation is theta^m * (1-theta)^n
## 7) Then theta | D ~ Beta(a+m, b+n)
## 8) Beta(a+m, b+n) is the "posterior" distribution for theta.

curve(dbeta(x, 3, 8), from = 0, to = 1, col = 'blue')
curve(dbeta(x, 8, 3), from = 0, to = 1, col = 'yellow', add = TRUE)
curve(dbeta(x, 7, 4), from = 0, to = 1, col = 'red', add = TRUE)

## Above, we've modeled theta with 3 different priors. Notice that they look
## really different!

## Now let's flip 100 coins; we get 58 heads and 42 tails...what does the
## posterior distribution look like now?

## Intuitive understanding: to define the "prior" distribution Beta(a, b), we
## saw (a+b-2) imaginary trials, of which (a-1) are "successes."
## After observing n + m new trials, of which n are "successes," the
## "posterior" distribution is Beta(a+n, b+m).

curve(dbeta(x, 3 + 58, 8 + 42), from = 0, to = 1, col = 'blue')
curve(dbeta(x, 7 + 58, 4 + 42), from = 0, to = 1, col = 'red', add = TRUE)

curve(dbeta(x, 3 + 580, 8 + 420), from = 0, to = 1, col = 'blue')
curve(dbeta(x, 7 + 580, 4 + 420), from = 0, to = 1, col = 'red', add = TRUE)


## Do you understand the shapes of each of these curves?

curve(dbeta(x, 10, 10), from = 0, to = 1, col = 'green')
curve(dbeta(x, 2, 8), from = 0, to = 1, col = 'purple', add = TRUE)
curve(dbeta(x, 8, 2), from = 0, to = 1, col = 'blue', add = TRUE)
curve(dbeta(x, 5, 5), from = 0, to = 1, col = 'red', add = TRUE)
curve(dbeta(x, 1, 1), from = 0, to = 1, col = 'yellow', add = TRUE)
curve(dbeta(x, 2, 2), from = 0, to = 1, add = TRUE)


#$ Animated Beta:

AnimatedBeta <- function(a = 1, b = 1, prob = runif(1), frames = 100,
                         sleep = .1, other = FALSE, other.a, other.b) {
  ## Animates posterior beta distributions after independent bernoulli trials.
  ## Args:
  ##   a, b - "prior" parameters
  ##   prob - probability of successful coin flip
  ##   frames - number of posterior distributions to display (i.e. number
  ##     of coin flips)
  ##   sleep - time (in seconds) between frames
  ##   other - if TRUE, displays a second prior distribution
  ##   other.a, other.b - "prior" parameters for second distribution

  beta.vals <- c(a, b)
  if (other) other.beta.vals = c(other.a, other.b)

  for (i in 1:frames) {
    curve(dbeta(x, beta.vals[1], beta.vals[2]),
          from = 0, to = 1, col = 'blue')
    if (other) curve(dbeta(x, other.beta.vals[1], other.beta.vals[2]),
                     from = 0, to = 1, col = 'green', add = TRUE)
    outcome <- sample(1:2, 1, prob = c(prob, 1-prob))
    beta.vals[outcome] <- beta.vals[outcome] + 1
    if (other) other.beta.vals[outcome] <- other.beta.vals[outcome] + 1
    Sys.sleep(sleep)
  }

  ## Display the real probability.
  abline(v = prob, col = 'red')
  return(prob)
}

AnimatedBeta()
AnimatedBeta(other = TRUE, other.a = 3, other.b = 11)
AnimatedBeta(1, 1, prob = .4364706, other = TRUE, other.a = 88, other.b = 44)
