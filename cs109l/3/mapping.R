## File: mapping.R
## Author: John Rothfels (rothfels)
## Description: Mapping Functions


## To facilitate vector-based programming, R provides a family of powerful
## and flexible functions that enable the vectorization of user-defined
## functions: apply, sapply, lapply, tapply, mapply, rapply.

## The effect of sapply(X, FUN) is to apply function FUN to every element of
## vector X. That is, sapply(X, FUN) returns a vector whose i-th element is
## the value of the expression FUN(X[i]). If FUN has arguments other than
## X[i], then they can be included using sapply(X, FUN, ...), which returns
## FUN(X[i], ...) as the i-th element. Note that the value of the ...
## arguments are the same the same each time FUN is called.

rnum <- function(elem) {
  return(runif(1, min = 0, max = elem))   # random number between 0 and elem
}

sapply(1:10, rnum)

## The 's' in 'sapply' stands for "simplify," meaning that R will return
## the simplest representation which can describe the result of the mapping.
## By setting the 'simplify' argument to FALSE, R will return a list. This
## is the default return type for mapping results which have cannot simplify.

rnum.n <- function(elem, n) {
 return(runif(n, min = 0, max = elem))    # n random numbers
}

sapply(1:10, rnum.n, n = 3)
sapply(1:10, rnum.n, n = 3, simplify = FALSE)
sapply(1:10, rnum.n, elem = 1)


## We can define anonymous functions in our calls to sapply.

sapply(1:10, function(elem) return(elem + 1))

## Watch out for some (seemingly) strange behavior. Although the vector 'x'
## below has been given a $names attribute, the overall effect of sapply
## has not changed.

x <- sapply(c("hello", "world"), function(elem) return(runif(1)))
x
attributes(x)
prod(x)

sapply(c("hello", "world"), function(elem) return(runif(1)), USE.NAMES = FALSE)


## Now, let's fix the 'fact' function from last lecture to support vector
## input elegantly.

fact <- function(x) {
  ## Computes x! (vectorized)
  ##
  ## Arguments:
  ##   x - numeric vector

  return(sapply(x, fact.single <- function(elem) {
    if (elem < 0) return(NaN)
    if (elem == 0 | elem == 1) return(1)
    return(elem * fact.single(elem - 1))
  }))
}


## The generic version of 'sapply' is 'lapply'. The 'l' stands for "list"
## since lapply always returns a list whose ith component is the result
## of applying a function to the ith element of your input. Note that
## sapply(*, simplify = FALSE, USE.NAMES = FALSE) is equivalent to lapply(*).

## In addition to mapping over vectors, sapply and lapply can map over the
## elements of a list.

sapply(list(1:10, 1:100, 1:1000), mean)
lapply(list(1:10, 1:100, 1:1000), mean)



## If you wish to apply a function to each of the rows (or columns) of a
## matrix, use the function 'apply', which is a more flexible but more
## complex version of sapply.

apply(matrix(1:20, nrow = 2), 1, mean)          # apply over rows
apply(matrix(1:20, nrow = 2), 2, mean)          # apply over columns



## R also allows you to map non-unary functions (i.e. functions which take
## more than one argument) over multiple inputs.
## Let's begin with a motivating problem. First, recall:

rep(1:2)
rep(1:2, times = 2)
rep(1:2, each = 2)
rep(1:2, 1:2)

## Suppose I want to map over multiple vectors in parallel (not the "parallel"
## you know from threading; here we mean to apply a single function over
## multiple vectors to produce one result). We would want to do this if we
## were trying to apply a function defined over multiple arguments.
## For example, if I have the vectors (1 2 3 4) and (4 3 2 1), and I want to
## apply 'rep' to these vectors, I should get a list with these elements:
##
##   rep(1,4)           # repeat 1, 4 times
##   rep(2,3)           # repeat 2, 3 times
##   rep(3,2)           # repeat 3, 2 times
##   rep(4,1)           # repeat 4, 1 time

## To map over multiple lists/vectors, use the function 'mapply'. The 'm'
## stands for "multiple".

mapply(rep, 1:4, 4:1)
mapply(rep, times = 1:4, x = 4:1)
mapply(rep, x = 4, times = 1:4)         # vector recycling performed on 4

## If we want an argument to our function to be constant over the mapping
## (i.e. continually recycled), use the optional 'MoreArgs' parameter. This
## corresponds (roughly) to the ... argument of sapply and lapply.

mapply(rep, times = 1:4, MoreArgs = list(x = 4))

## There are some cool additional mapply features that we may not have time
## to cover in class, but that are very fun to take a look at.

rep.int(1:4, times = 2)         # simplified version of rep

Vectorize(rep.int)              # returns a function which "vectorizes" the
                                # arguments of rep.int

rep.int(1:4, 4:1)
vrep <- Vectorize(rep.int)
vrep(1:4, 4:1)
vrep(times = 1:4, x= 4:1)

## With the 'Vectorize' function, we can explicitly tell R what parameters
## we want to vectorize over.

vrep <- Vectorize(rep.int, "times")
vrep(times = 1:4, x = 4:1)

vrep <- Vectorize(rep.int, c("times","x"))
vrep(times = 1:4, x = 4:1)



seq_along(10:20)               # very fast primitive for common cases
seq_len(10)                    # another very fast primitive

mapply(function(x, y) return(seq_len(x) + y), 1:3, c(10, 0, -10))


word <- function(C, k) return(paste(rep.int(C, k), collapse=''))
word(1:2, 3)

mapply(word, LETTERS[1:6], 6:1)
mapply(word, LETTERS[1:6], 6:1, USE.NAMES = FALSE)
mapply(word, LETTERS[1:6], 6:1, SIMPLIFY = FALSE)


## There are two other functions in the mapping family (tapply and rapply),
## but we will not be using these during the course. The function 'tapply'
## is used to generate tables, and the function 'rapply' is used for
## recursive application of functions. It's *really* neat, so if you feel
## like being an overachiever, I recommend you take a look at its
## documentation: ?rapply.




## Exercises:
## ---------

## See if you can guess what each of the 'print' lines below will output.

f <- function(x = 1:3, y) return(c(x, y))
vf <- Vectorize(f)
print(vf(1:3, 1:3)
vf <- Vectorize(f, SIMPLIFY = FALSE)
print(vf(1:3, 1:3))
print(vf(y = 1:3))
