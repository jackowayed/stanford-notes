## File: functional2.R
## Author: John Rothfels (rothfels)
## Description: Functional Programming (part 2)
## --------------------------------------------


## Write the 'Combinations' function, which given a 'set' of elements returns
## a list of all combinations of those elements taken k at a time. Your
## function should work similarly to 'combn', the difference being that you
## don't need to worry about simplifying your result into a matrix.
## Your function should be recursive and use at least one mapping function.

Combinations <- function(set, k) {
  ## Enumerates the combinations of the numeric vector 'set' taken 'k' at a
  ## time. Your output should be a list, each element of which is a
  ## combination (i.e. numeric vector) of length k.
  ##
  ## Arguments:
  ##   set - items to choose from (numeric vector)
  ##   k - number of elements in each combination
  ## Returns:
  ##   list of numeric vectors.

  if (length(set) == k) return(list(set))
  if (k == 0) return(list(numeric()))

  comb.without <- Combinations(set[-1], k)
  comb.with <- Combinations(set[-1], k - 1)
  return(c(comb.without,
           lapply(comb.with, function(subset) c(set[1], subset))))
}

## Now rewrite the 'Powerset' function leveraging off the code you just wrote.

Powerset <- function(set) {
  ## Computes the powerset of 'set'.
  ##
  ## Arguments:
  ##   set - numeric vector
  ## Return:
  ##   list of numeric vectors

  return(unlist(lapply(0:length(set), function(k) Combinations(set, k)),
                recursive = FALSE))
}

## Make sure you understand why we needed to do one level of unlisting above.


## Now write the 'Permutations' function, which given a vector of distinct
## items produces a list of all the permutations of those items. Your function
## should be recursive, and implemented with whatever mapping functions you
## choose (no for loops, please). The output should be identical to that of
## 'permn'.

Permutations <- function(items) {
  ## Enumerates the permutations of the numeric vector 'items'. Your output
  ## should be a list, each element of which is a permutaiton of items
  ## (i.e. a numeric vector).
  ##
  ## Arguments:
  ##   items - numeric vector to permute
  ## Returns:
  ##   list of numeric vectors

  if (length(items) == 0) return(list(numeric()))

  result <- lapply(seq_along(items), function(index) {
    lapply(Permutations(items[-index]), function(permutation) {
      c(items[index], permutation)
    })
  })

  return(unlist(result, recursive = FALSE))
}




## Exercises:
## ----------

## VERY DIFFICULT:
## Write the 'Derangements' function, which generates a list of all of the
## permutations of a sequence (vector) of numbers under the constraint that
## no element resides in its original position. For instance, (2 4 1 3) is a
## derangement of (1 2 3 4), but (3 2 4 1) is not. In practice, the number of
## derangements is about one third the number of permutations (in reality, as
## the length of sequence gets larger and larger, the ratio of the number of
## permutations to the number derangements converges to e). As a result, your
## solution should construct the derangements from scratch and never synthesize
## a permutation that isn't a derangement. Specifically, you should not
## generate all permutations and then just filter out those that aren't
## derangements. That would take about 3 times as long as necessary.
##
## Hint: you may find it helpful to modify the function definition below
## to include extra arguments with default values. This is equivalent to
## writing a wrapper function.
##
## Now, use your Derangements function to compute how many derangements there
## are of the vector 1:10. Can you compute this value analytically? Email me
## if you want me to check your answers.

Derangements <- function(seq) {
  ## Enumerates the derangements of the numeric vector 'seq'. Your output
  ## should be a list, each element of which is a derangement of seq
  ## (i.e. a numeric vector).
  ##
  ## Arguments:
  ##   seq - numeric vector to derange
  ## Returns:
  ##   list of numeric vectors

  return(NULL)
}
