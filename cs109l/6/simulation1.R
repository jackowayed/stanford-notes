## File: simulation1.R
## Author: John Rothfels (rothfels)
## Description: Monte Carlo Simulation
## -----------------------------------

## THREE DOOR MONTY
## ----------------

ThreeDoorMonty <- function(switch) {
  ## Simulates a game of Three Door Monte, with the strategy 'switch'.
  ## If 'switch' = TRUE, we choose to switch our door when prompted.

  door.with.prize <- sample(1:3, 1)
  door.chosen <- sample(1:3, 1)
  open.choices <- (1:3)[-c(door.with.prize, door.chosen)]
  if (length(open.choices) == 1) door.opened <- open.choices
  else door.opened <- sample(open.choices, 1)
  if (switch) door.chosen <- (1:3)[-c(door.opened, door.chosen)]
  return(door.chosen == door.with.prize)
}

mean(replicate(10000, ThreeDoorMonty(FALSE)))
mean(replicate(10000, ThreeDoorMonty(TRUE)))


## Simulate 10000 values of a uniform (0, 1) random variable U1 using runif(),
## and simulate another set of 10000 values of a uniform (0, 1) random variable
## U2. Since the values in U1 and U2 are approximately independent, we can
## view U1 and U2 as independent uniform (0, 1) random variables.

u1 <- runif(10000)
u2 <- runif(10000)
u <- u1 + u2

## Estimate E[U1 + U2]. Compare with the true value, and compare with an
## estimate of E[U1] +  E[U2].

mean(u)
mean(3*u)
3*mean(u)
mean(u1) + mean(u2)

## Estimate Var(U1 + U2) and Var(U1) + Var(U2). Are they equal?
## Should the true values be equal?

var(u)
var(2*u)
2*var(u)
var(u1) + var(u2)

## Estimate P(U1 + U2 <= 1.5)
mean(u <= 1.5)

## Estimate P(sqrt(U1) + sqrt(U2) <= 1.5)
u.sqrt <- sqrt(u1) + sqrt(u2)
mean(u.sqrt <= 1.5)


## When can this go wrong??

## ST. PETERSBURG PARADOX
## ----------------------

StPetersburg <- function(n) {
  ## Simulates the St. Petersburg paradox.

  sapply(1:n, function(i) {
    pot.amount <- 1
    while (TRUE) {
      if (sample(c("H","T"), 1) == "H") pot.amount <- pot.amount*2
      else break
    }
    return(pot.amount)
  })
}

mean(StPetersburg(100000))
mean(StPetersburg(100000))
mean(StPetersburg(100000))
mean(StPetersburg(100000))
mean(StPetersburg(100000))
mean(StPetersburg(100000))

range(StPetersburg(100000))

## We can do our best to give a real "approximate" value.

mean(sapply(1:100, function(i) mean(StPetersburg(1000))))

## Anybody want to play??? :)


## BIRTHDAY PROBLEM
## ----------------

BirthdaySim <- function(n, r, trials = 10000) {
  ## Computes the approximate probability that in a group of n people
  ## n - r people do not have unique birthdays.
  ##
  ## Args:
  ##   n - number of people
  ##   r - number of people to share a birthday
  ##   trials - number of Monte Carlo simulations to run

  mean(sapply(1:trials, function(i) {
    random.birthdays <- sample(1:365, n, replace = TRUE)
    return(length(unique(random.birthdays)) == (n - r))
  }))
}

BirthdaySim(22, 0)
BirthdaySim(23, 0)

plot(5:50, sapply(5:50, BirthdaySim, r = 0, trials = 1000))
abline(h = .5, col = "blue")


## The following problem was first stated as a challenge question in the
## August-September 1941 issue of the American Mathematical Monthly (p. 483).
## Originated by G.W. Petrie, of the South Dakota State School of Mines.

## Three men have respectively l, m, and n coins which they match so that the
## odd man wins. In case all coins appear alike, they repeat the throw. Find the
## average number of tosses required until one man is forced out of the game.

## When playing, each man selects one of his coins, and then all three
## simultaneously flip. If two coins show the same side and the third coin
## shows the opposite side, then the two men whose coins matched give those
## coins to the odd man out. If three heads or three tails is the outcome,
## however, nobody wins or loses on that toss. This process continues until
## one of the men loses his last coin. Notice that when you lose, you lose
## one coin, but when you win, you win two coins. Write a function that can
## take variable values of l, m, and n, as well as the value of p
## (coin "fairness"). If l = 1, m = 2, and n = 3, the theoretical answer (for
## p = .5) is that the average length of a sequence is two tosses.

CoinFlippingGame <- function(l, m, n, p = .5, trials = 10000) {
  mean(sapply(1:trials, function(i) {
    players <- c(l, m, n)
    sequence <- 0
    while (prod(players) != 0) {
      while (TRUE) {
        sequence <- sequence + 1
        toss <- sample(0:1, 3, replace = TRUE, prob = c(1-p, p))
        if (sum(toss) != 0 && sum(toss) != 3) break
      }

      if (sum(toss) == 1) {
        players[toss == 0] <- players[toss == 0] - 1
        players[toss == 1] <- players[toss == 1] + 2
      } else {
        players[toss == 1] <- players[toss == 1] - 1
        players[toss == 0] <- players[toss == 0] + 2
      }
    }
    return(sequence)
  }))
}




## Exercises:
## ----------

## If a burglar walks up and down along an infinity of towns (homes) that are
## spaced uniformly along a line, taking with equal probability steps of
## either one or two towns (homes) in either direction (also with equal
## probability) to arrive at his next location, how long can our man get away
## with his crooked trade? That is, how long is it before a previously
## hoodwinked town or a previously burgled home is revisited?

## Can you allow for an arbitrary number of steps?

BurglarProblem <- function(n, trials = 10000) {
  return(NULL)
}
