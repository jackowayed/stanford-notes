## File: functions.R
## Author: John Rothfels (rothfels)
## Description: Functions in R
## ---------------------------

## Before we see how to write functions in R, let's look at R's mechanisms
## for control flow and looping.

## R's 'if' statement controls of which lines of code are executed.
## Syntax: if (condition) {commands when TRUE}
##         if (condition) {commands when TRUE} else {commands when FALSE}

if (TRUE) print("hello world")
if (FALSE) print("goodbye, cruel world")

## R can be temperamental when it comes to mixing 'if' and 'else' with line
## breaks and curley brackets. Be careful

## Good: "goodbye, cruel world"
{
  if (FALSE) print("hello world")
  else print("goodbye, cruel world")
}

## Bad: raise error
if (FALSE) print("hello world")
else print("goodbye, cruel world")

## Good: "goodbye, cruel world"
if (FALSE) print("hello world") else print("goodbye, cruel world")

## Good: "goodbye, cruel world"
if (FALSE) {
  print("hello world")
} else {
  print("goodbye, cruel world")
}

# Bad: raise error
if (FALSE) {
  print("hello world")
}
else {
  print("goodbye, cruel world")
}


## R's 'for' loop can be used for iteration.
## Syntax: for (name in vector) {commands}

count <- 1:10
for (i in count) {
  print(i)
}


## R's 'while' loop can also be used for iteration.
## Syntax: while (condition) {statements}

count <- 1
while (count <= 10) {
  print(count)
  count <- count + 1
}


## When inside 'for' and 'while' loops, use 'break' and 'next' so stop and
## continue iteration, respectively.

count <- 1
while (TRUE) {             # you may also use 'repeat { ... }'
  print(count)
  count <- count + 1
  if (count > 10) {
    break
  }
}

count <- -5
while (count <= 10) {
  if (count < 1) {
    count <- count + 1
    next
  }
  print(count)
  count <- count + 1
}




## In R, functions are treated as objects in the same way that that vectors
## and lists are. You may therefore pass functions as arguments to other
## functions. In addition, R supports anonymous functions creation
## (lambda expressions, for those familiar with them from Lisp or Haskell).
## We will see how this these functions are useful when we learn about
## functional programming.
## For now, let's look at how to write a some very basic functions.

myfn <- function(arg1, arg2) {
  print(arg1)
  print(arg2)
  return(NULL)
}

## Notice that 'arg1' and 'arg2' do not have explicit types, so we may pass
## any class of object.

myfn(1, 2)
myfn("hello", "world")
myfn(sort, order)

## If we want to enforce parameters to be objects of a specific class,
## this must be done inside the function with explicit 'stop' statements
## that force execution of a function to terminate.

myfn <- function(arg1, arg2) {
  if (!is.numeric(arg1)) {
    stop("Insert your error message here.")
  }
  return(NULL)
}

myfn(sort, order)

## Return values from a function using the 'return' statement. If a function
## ends without hitting a 'return' line, the return value of the function
## will be the return value of the last line of code executed in the function.
## As a stylistic guideline, however, you should always use 'return'
## statements.

myfn <- function(arg1, arg2) {
  arg1 > arg2
}

myfn(1, 2)
myfn(2, 1)

## Set default values for arguments in the function definition with '='.

myfn <- function(arg1 = "hello", arg2 = "world") {
  cat(arg1, arg2)
}

myfn()
myfn("goodbye, cruel")


## Let's see how a real function might look.

fact <- function(x) {
  ## Function to compute x!
  ## Args:
  ##   x - an integer value (of class "numeric")

  if (!is.numeric(x)) {
    stop("x must be of class 'numeric'")
  }
  if (x %% 1 != 0) {
    stop("x must be an integer")
  }
  if (length(x) != 1) {
    stop("x must be a vector of length 1")
  }

  if (x < 0) return(NaN)
  if (x == 0) return(1)
  return(x * fact(x-1))
}

fact(0)
fact(1)
fact(3)
fact(-1)

## Our 'fact' function will only work on unit length vectors. To "vectorize"
## the function (i.e. allow the length of 'x' to be greater than 1, we can
## modify our function as follows:

fact <- function(x) {
  ## Function to compute x!
  ## Args:
  ##   x - a numeric vector

  if (!is.numeric(x)) {
    stop("x must be of class 'numeric'")
  }

  ## We define an inner function (which exists only in the scope of 'fact')
  ## which computes the factorial of a single value, as we've done above).
  fact.singleValue <- function(x) {
    if (x %% 1 != 0) {
      stop("Not an integer value: ", x)   # concatenates arguments together
    }

    if (x < 0) return(NaN)
    if (x == 0) return(1)
    return(x * fact(x-1))
  }

  for (i in 1:length(x)) {
    x[i] <- fact.singleValue(x[i])
  }
  return(x)
}

fact(1:5)
fact(c(-1, 3, 5, 7.6))


## Note that R has a built in factorial function which is also vectorized,
## and also defines a factorial value for real valued arguments. You should
## use this one, even though ours was cool.

factorial(1:5)
factorial(1.3)


## Here's another function which will show up a lot during your combinatorics
## unit in CS109. Make sure you understand how/why this works. For our
## purposes, we'll leave out the error handling and just assume the user
## calls the function with integer values for n and k.

combinations <- function(n, k) {
  ## Computes the number of combinations of n elements taken k at a time.

  if (k == 0 || n == k) return(1)
  return(combinations(n-1, k-1) + combinations(n-1, k))
}

## When a function has more than one argument, it takes slightly more
## imagination to see how it may be "vectorized". As an exercise, consider
## how the function should work with n and/or k as vectors with length
## greater than 1. When we learn about functional programming, we'll
## see how to solve this problem cleanly and effectively. We want an
## implementation which mimics R's 'choose' function.

choose(6, 3)
choose(3:5, 2)
choose(3:5, 2:4)
choose(3:6, 2:3)




## Exercises:
## ----------

## 1) Write a function to compute the "cumulative sum" of a vector. It
##    should work identically to R's 'cumsum' function, but should not
##    actually call 'cumsum'.

cumulative.sum <- function(x) {
  ## Computes the "cumulative sum" of x, returning a vector of the same
  ## length as x where the ith element of the new vector is the sum of
  ## the values x up to and including its ith value.

  return(NULL)
}

## 2) Write the function 'max.sum.subvector' which, given a numeric vector
##    returns the maximum sum you can create from a contiguous block of
##    elements from the vector (i.e. all elements between indices i and j).
##    For example, max.sum.sublist(c(-1, 3, -10, 6, 7, -5, 2)) should
##    return "13" from adding 6 and 7 together.
##    DIFFICULT: do this in O(n) runtime. Email me if you'd like me to check
##      your solution, then pat yourself on the back for figuring this out.

max.sum.subvector <- function(x) {
  ## Computes the maximum sum subvector of x, defined above.

  return(NULL)
}
