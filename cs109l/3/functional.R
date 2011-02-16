## File: functional.R
## Author: John Rothfels (rothfels)
## Description: Functional Programming in R
## ----------------------------------------


## From Wikipedia:
## "Functional programming is a programming paradigm that treats computation
## as the evaluation of mathematical functions and avoids state and mutable
## data. It emphasizes the application of functions, in contrast to the
## imperative programming style, which emphasizes change in state."

## "In practice, the difference between a mathematical function and the notion
## of a 'function' used in imperative programming is that imperative functions
## can have side effects, changing the value of already calculated computations.
## Because of this, they lack referential transparency, i.e. the same
## expression can result in different values at different times depending on
## the state of the executing program. Conversely, in functional code, the
## output value of a function depends only on the arguments that are input to
## the function."

## For our introductory purposes, a few themes (or elements) will pop up as
## we look at the functional paradigm in R. They are:
##   - Lists
##   - Recursion
##   - Mapping
##   - Anonymous ("lambda") functions

## We'll proceed by jumping right in and writing some functions.

Product <- function(x) {
  ## Computes the product of each of the elements of x.
  ##
  ## Arguments:
  ##   x - a numeric vector

  if (length(x) == 0) return(1)
  return(x[1] * Product(x[-1]))
}

Product.List <- function() {
  ## Computes the product of each of the elements of x.
  ##
  ## Arguments:
  ##   x - a list whose elements are numeric vectors of length 1

  if (length(x) == 0) return(1)
  return(x[[1]] * Product.List(x[-1]))
}

IsSorted <- function(x) {
  ## Returns a boolean indicating whether the elements in the vector
  ## x are in sorted order. Returns TRUE for ascending order of elements
  ## (i.e. x[1] <= x[2] <= x[3] ...).
  ##
  ## Arguments:
  ##   x - a numeric vector

  if (length(x) < 2) return(TRUE)
  return(x[1] <= x[-1][1] && IsSorted(x[-1]))
}

IsSorted.List <- function(x, cmpfn = `<=`) {
  ## Returns a boolean indicating whether the elements in the list
  ## 'x' are in sorted order. For non-default 'cmpfn', cmpfn(elem1, elem2) is
  ## TRUE if elem1 <= elem2, else FALSE.
  ##
  ## For unspecified cmpfn, defaults to `<` operator. Note that operators
  ## are treated as functions when written with back tics. So the following
  ## is a valid line of code:
  ##
  ##   > `<`(3, 5)
  ##   [1] TRUE
  ##
  ## Returns TRUE for ascending order of elements,
  ## (i.e. x[[1]] <= x[[2]] <= x[[3]] ...)
  ##
  ## Arguments:
  ##   x - a list
  ##   cmpfn - comparison function for the elements of x

  if (length(x) < 2) return(TRUE)
  return(cmpfn(x[[1]], x[-1][[1]]) && IsSorted.List(x[-1], cmpfn))
}

## An important pattern to recognize in the functions we have seen so far
## is that we operate over lists by retrieving the first element, doing some
## computation, and somehow recursing on the remainder of the list. Let's see
## some more of this.

Flatten <- function(seq) {
  ## Recursively unlists 'seq' into its constituent vectors and concatenates
  ## these vectors together.
  ##
  ## Arguments:
  ##   seq - a list, each element of which is either a numeric vector or a
  ##     list which also follows this rule

  if (length(seq) == 0) return(numeric())
  if (is.list(seq[[1]])) return(c(Flatten(seq[[1]]), Flatten(seq[-1])))
  return(c(seq[[1]], Flatten(seq[-1])))
}

Powerset <- function(set) {
  ## Computes the powerset of the elements in 'set'. The powerset is the set
  ## of all subsets of a set.
  ##
  ## Assumptions:
  ##   1) x is a numeric vector.
  ## Returns:
  ##   List of numeric vectors, each vector a subset of 'set'.
  ## Hint:
  ##   Powerset({1, 2, 3}) = {{ } {1} {2} {3} {1 2} {2 3} {1 3} {1 2 3}}
  ##   Written differently, this looks as follows"
  ##     {{ } {2}   {3}   {2 3}        # Powerset({2, 3})
  ##      {1} {1 2} {1 3} {1 2 3}}     # union 1 to each set in line above

  if (length(set) == 0) return(list(numeric()))
  return(c(Powerset(set[-1]),
           lapply(Powerset(set[-1]), function(subset) {
             return(c(set[1], subset))
           })))
}

Powerset.Alt <- function(set) {
  ## Computes the powerset of the elements in 'set'. This version uses
  ## caching to prevent extra recursive calls.
  ##
  ## Assumptions:
  ##   1) x is a numeric vector.
  ## Returns:
  ##   List of numeric vectors, each vector a subset of 'set'.

  if (length(set) == 0) return(list(numeric()))
  pset.of.rest <- Powerset.Alt(set[-1])               # caching
  return(c(pset.of.rest,
           lapply(pset.of.rest, function(subset) {
             return(c(set[1], subset))
           })))
}


## The following two functions implement the "mergesort" algorithm
## to sort a numerical vector 'x'.

Merge <- function(list1, list2) {
  ## Merges two sorted vectors into one sorted vector using the "merge"
  ## algorithm.
  ##
  ## Arguments:
  ##   list1 - first sorted numeric vector
  ##   list2 - second sorted numeric vector

  if (length(list1) == 0) return(list2)
  if (length(list2) == 0) return(list1)
  if (list1[1] < list2[1]) return(c(list1[1], merge(list1[-1], list2)))
  return(c(list2[1], merge(list1, list2[-1])))
}

Mergesort <- function(x) {
  ## Runs the "mergesort" algorithm on 'x'.
  ##
  ## Arguments:
  ##   x - numerical vector to sort

  if (length(x) <= 1) return(x)
  l <- length(x)
  return(merge(mergesort(x[1:(l %/% 2)]), mergesort(x[(l %/% 2 + 1):l])))
}




## Exercises:
## ----------


## 1) Implement the ContinuedFraction function, which takes a vector of the form
##    [a0 a1 a2 a3 ... an] and assumes it to be an appreviated representation
##    of the following continued fraction:
##      a0 + 1 / (a1 + 1 / (a2 + 1 / (a3 + 1 / ...)))
##    You may assume that the denoms list is nonempty and contains only
##    positive integers.

ContinuedFraction <- function(denoms) {
  ## Computes the continued fraction of 'denoms', defined above.
  ##
  ## Arguments:
  ##   denoms - numeric vector

  if (length(denoms) == 1) return(denoms)
  return(denoms[1] + 1 / ContinuedFraction(denoms[-1]))
}


## 2) Write the IsSubsequence routine, which returns TRUE if and only if the
##    vector identified by 'needle' is a subvector of the vector identified by
##    'haystack'. A vector is a subvector of another if it's an ordered
##    subset of the other. Your implementation must run in linear time.
##    Examples:
##      IsSubsequence(numeric(), 1:5) -> TRUE
##      IsSubsequence(c(1, 3, 4), 1:5) -> TRUE
##      IsSubsequence(c(3, 7), 1:5) -> FALSE
##      IsSubsequence(c(5, 3, 1), 1:5) -> FALSE

IsSubsequence <- function(needle, haystack) {
  ## Determines whether 'needle' is a subvector of 'haystack', defined above.
  ##
  ## Arguments:
  ##   needle - numeric vector
  ##   haystack - numeric vector

  if (length(needle) == 0) return(TRUE)
  if (length(haystack) == 0) return(FALSE)
  if (needle[1] == haystack[1]) return(IsSubsequence(needle[-1], haystack[-1]))
  return(IsSubsequence(needle, haystack[-1]))
}

## 3) Write the Quicksort routine, which sorts the elements of 'x' using the
##    quicksort algorithm.

Partition <- function(pivot, x) {
  ## Partitions the numeric vector 'x' into a list of two numeric vectors.
  ## The first vector of the partition list contains the elements of x which
  ## are less than the pivot value. The second vector of the partition list
  ## contains the elements of x which are greater than the pivot value.
  ##
  ## Arguments:
  ##   x - numeric vector to partition
  ##   pivot - numeric value to partition by

  if (length(x) == 0) return(list(numeric(), numeric()))
  split.of.rest <- partition(pivot, x[-1])
  if (x[1] < pivot) {
    return(list(c(x[1], split.of.rest[[1]]), split.of.rest[-1][[1]]))
  }
  return(list(split.of.rest[[1]], c(x[1], split.of.rest[-1][[1]])))
}

Quicksort <- function(x) {
  ## Runs the quicksort algorithm on x.
  ##
  ## Arguments:
  ##   x - numeric vector to sort

  if (length(x) <= 1) return(x)
  split <- partition(x[1], x[-1])
  return(c(quicksort(split[[1]]), x[1], quicksort(split[-1][[1]])))
}
