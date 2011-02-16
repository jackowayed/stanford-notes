## File: combinatorics.R
## Author: John Rothfels (rothfels)
## Description: Probability and Combinatorics
## ------------------------------------------

## Computing combinatoric forms in R can be extremely quick and easy.
## Here are some of the tools you will want to use:

factorial(5)
factorial(0:6)

choose(5, 3)
choose(3:5, 3)         # choose(3,3)  choose(4,3)  choose(5,3)
choose(5, 1:5)         # choose(5,1)  choose(5,2)  ...  choose(5,5)

## From a group of 5 women and 7 men, how many different committees can be
## formed consisting of 2 women and 3 men? What if 2 of the men are feuding
## and refuse to serve on the committee together?

choose(5, 2) * choose(7, 3)
choose(5, 2) * choose(7, 3) - choose(5, 2) * choose(2, 2) * choose(5, 1)

## If we don't know how (or just don't want) to solve this problem
## analytically, we can use brute-force alternatives. The 'combn' function
## enumerates all combinations of the elements of a vector of length n,
## chosen r at a time:

?combn
combn(1:5, 3)
length(combn(1:5, 3))      # r * choose(n, r) = 3 * choose(5, 3) = 30

## The default is for combn to return an (r by choose(n,r)) dimensional matrix
## with each column representing one possible combination of the elements of
## the vector 'x'. This can be frustrating to those who expect a list of the
## combinations, rather than an array. Similar to 'sapply', we can turn
## this simplification behavior off.

combn(1:5, 3, simplify = FALSE)
length(combn(1:5, 3, simplify = FALSE))       # choose(5, 3) = 10

## In your call to combn, you may supply an additional function parameter
## which will be mapped over each combination generated. This can be incredibly
## useful.

combn(1:5, 3, function(x) sum(x == 1) > 0)

## Q: What does the following line of code output?
## A: The number of combinations of the elements 1:5 taken 3 at a time
##    which contain the number 1.

sum(combn(1:5, 3, function(x) sum(x==1) > 0))
choose(1, 1) * choose(4, 2)

## This useful procedure can be applied to all sorts of counting problems.

## What about permutations? In the 'combinat' library (which you can install)
## there is a function 'permn' which works almost identically to combn, the
## only difference being that it will not default to simplify the resulting
## list of permutations to a matrix representation.

library(combinat)

permn(1:5)
length(permn(1:5)) == factorial(5)

## The following is a solution to the committee problem from above. We
## represent the group of people as a numeric vector, values 1-5 representing
## women and 11-17 representing men. We arbitrarily assign men 11 and 12 to
## be feuding.

people <- c(1:5, 11:17)

IsMan <- function(x) {
  return(x >= 11 && x <= 17)
}

IsWoman <- function(x) {
  return(x >= 1 && x <= 5)
}

IsFeuding <- function(x) {
  return(x == 11 || x == 12)
}

IsValidCommittee <- function(x) {
  return(sum(IsMan(x)) == 3 && sum(IsWoman(x)) == 2 && sum(IsFeuding(x)) != 2)
}

sum(combn(people, 5, IsValidCommittee))


## What is the probability of being dealt a pair in a 5 card poker hand?

mean(combn(rep(1:13, 4), 5, function(x) length(unique(x)) == 4))

## Note that the above computation takes about three minutes, but that's long
## enough to compute the problem analytically. By the time you're finished,
## you'll be able to check your answer

system.time({ mean(combn(rep(1:13, 4), 5,
                         function(x) length(unique(x)) == 4)) })

## Consider a set of n antennas of which m are defective and n - m are
## functional and assume that all of the defectives and all of the
## functionals are considered indistinguishable. How many linear orderings are
## there in which no two defectives are consecutive?

AntennaProblem <- function(n, m) {
  antennas <- c(rep(0, m), rep(1, n - m))
  IsValid <- function(x) {
    for (i in 1:(length(x) - 1)) {
      if (x[i] == 0 && x[i+1] == 0) return(FALSE)
    }
    return(TRUE)
  }
  values <- permn(antennas)
  values <- unique(values)	  # since antennas indistinguishable
  return(sum(sapply(values, IsValid)))
}

AntennaProblem(7, 2)


## Counting Degenerate Binary Search Trees (from CS109 Problem Set 1)

IsDegenerate <- function(x) {
  ## Returns a boolean indicating whether inserting the values of the
  ## numeric vector 'x' in order would constitute a degenerate
  ## binary search tree.
  ##
  ## Arguments:
  ##   x - numeric vector of values to insert in tree

  if (length(x) == 1) return(TRUE)
  return((all(x[1] < x[-1]) || all(x[1] > x[-1])) && IsDegenerate(x[-1]))
}

P.DegenerateTree <- function(n) {
  ## Returns the probability that a binary search tree with n items
  ## will be degenerate, assuming each tree structure is equally likely.

  degens <- permn(1:n, IsDegenerate)
  return(mean(unlist(degens)))
}

P.DegenerateTree(3)
P.DegenerateTree(5)
P.DegenerateTree(8)


## (from CS109 Midterm, Spring 2009) Say we have a standard 52 card deck of
## cards, where the cards have the usual ordering of ranks:
## 2, 3, 4, 5, 6, 7, 8, 9, 10 , J, Q, K, A. Assume each card in the deck is
## equally likely to be drawn. Two cards are then drawn sequentially without
## replacement from the deck. What is the probability that the second card
## drawn has a rank greater than the rank of the first card drawn?

n.pairs <- choose(52, 2)
n.ways.to.draw <- num.pairs * 2    # 2! ways to order the two cards

## Using our old method, we may calculate all combinations of 2 cards from
## the deck. Each combination will count as a single 'win' as long as the two
## face values are not equal. Make sure you've convinced yourself why this
## is true.

IsSuccess <- function(x) {
  return(length(unique(x)) != 1)
}

deck <- rep(2:14, 4)
mean(combn(deck, 2, function(x) IsSuccess))

## Let's generalize our game and say that a player chooses 'n' cards and wins if the
## last card they choose is greater than the two that came before it.

CardGame <- function(n) {
  deck <- rep(2:14, 4)
  NumSuccess <- function(x) {
    x <- sort(x)
    if (x[n] > x[n-1]) return(factorial(n - 1))
    return(0)
  }
  n.outcomes <- choose(52, n) * factorial(n)
  return(sum(combn(deck, n, NumSuccess)) / n.outcomes)
}

CardGame(2)
CardGame(3)
CardGame(4)
