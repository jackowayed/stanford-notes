## File: vector.R
## Author: John Rothfels (rothfels)
## Description: R Vector Object
## ----------------------------


## Try typing in the following expressions in the R console. Note that
## whitespace is almost always optional, except within compound operators
## (like '%%' and '%/%' and '<-')

2
2 + 2
2 - 2
2 * 2
9 / 2         # normal division defaults to double precision
2 ^ 4
9 %% 2        # mod operator
9 %/% 4       # integer division


## R ships with various primitive mathematical functions.

sqrt(9)
cos(pi)       # argument in radians
log(1)        # natural log
exp(1)
log(exp(3))
floor(3.5)
ceiling(3.5)


## To create variables (objects), use the assignment operator: '<-'

x <- 2        # assignment
x             # printing
(x <- 2)      # assignment AND printing

2 * x
x             # NOTE: x not modified by previous line

y <- 3
x + y

## Both x and y are vectors of length one (even though they act like integers).
## To make longer vectors, use 'c(...)'.

x <- c(3, 1, 4, 1, 5)   # x is now a vector of length five

2 * x                   # componentwise arithmetic

x + c(1, 2, 3, 4, 5)    # c(3+1, 1+2, 4+3, 1+4, 5+5)

## When performing arithmetic with vectors of unequal length. The shorter
## vector is "recycled" enough times to equal the length of the longer vector.

c(1, 2, 3, 4, 5, 6) * c(1, 2)    # c(1*1, 2*2, 3*1, 4*2, 5*1, 6*2)

## You can make vectors by concatenating other vectors together.

y <- c(x, 0, x)
y

## Q: What will the following expression evaluate to?
## A: A vector of length 11: 2*x repeated 2.2 times, y repeated once, and
##    1 repeated 11 times.

2*x + y + 1

## R comes with built-in vector operations (i.e. functions which take vectors
## as arguments). Here are a few:

prod(x)
sum(x)
length(x)
mean(x)
var(x)
max(x)
min(x)
range(x)
sd(x)
sort(x)       # does not change the value of x, but returns a sorted vector
order(x)      # the sorted ordering of x by index


## When you see a function but you don't know what it does, you can
## look at its documentation.

?order
help(order)

## You can also search through documentation by topic, though I've
## always found this is better done in a Google search.

help("sort")

## What happens if we call a function without parenthesis?

order


## Using c(...) syntax can become annoying. Here are some alternatives.

1:30
30:1

n <- 5
1:n
1:n+1                 # NOTE: the ':' operator is very closely binding.
1:(n+1)               # This is different from what we have above.


## Let's take a brief tangent now and look at how R function calls work.
## Use 'args(fn)' to print the arguments of a function. This will only show
## you the names of the arguments, not what they mean. For that information,
## use '?fn' or 'help(fn)'.

args(log)

## Notice that the 'log' function actually has 2 parameters: 'x' and 'base'.
## The 'base' parameter is given a default value of 'exp(1)' while the 'x'
## parameter has no default value and is thus required in the function call.

log(exp(1))
log(100, 10)           # sets the 'base' parameter to be 10

## We can also make function calls by explicitly setting parameters by name.
## Each of these produces the same output as 'log(100, 10)'.

log(100, base = 10)
log(x = 100, base = 10)
log(base = 10, x = 100)

## Notice that when parameters are explicitly named, ordering does not matter.
## You can mix and match named and ordered arguments and R will figure out
## how to assign parameters using the default ordering in the function
## definition (the default order is shown by 'args').


## Back to vector instantiation, the ':' operator is generalized by the
## function 'seq(...)'.

2:10
seq(2, 10)

args(seq)

## R's '...' parameter is tricky to understand, and is one of the weirdest
## aspects of the language. Roughly speaking, '...' means that some arguments
## given to function are passed to other functions inside the original.
## For certain functions ('seq' included) certain named parameters have
## special meaning even they do not appear in the function signature. You
## can find these in the function documentation: '?seq' or 'help(seq)'.

seq(from = 2, to = 10)
seq(-5, 5, by = .2)
seq(from = -5, by = .2, length = 51)


## You can replicate vectors using the 'rep' function:

rep(x, times = 5)         # concatenate x together 5 times
rep(x, each = 5)          # each component of x copied 5 times



## R has logical values and operations.

TRUE
FALSE

## These variables are instantiated for convenience at the beginning of
## an R session, but they can be overwritten. Be careful!

T
F

if (TRUE) print("hello world")
if (FALSE) print("hello world")

## So far, we've seen numeric vectors (vectors which contain numeric data).
## R creates logical vectors with logical operators.

x > 3                     # logical operators are the same as in C, C++, Java


## Combine logical operators into logical expressions

x > 3 & x < 5             # single ampersand for componentwise evaulation
x > 3 && x < 5            # double ampersand for short-circuit evaluation
x < Inf && x > -Inf
x > 3 | x == 1
!(x > 3)


## R also has character vectors (where elements of the vector are each
## strings). You can create strings with "" or ''.

"hello world"
'goodbye, cruel world'

starwars <- c("luke", "yoda", "chewbacca", "darth vader",
              "emperor palpatine")

## The 'paste' function can be used for character vector manipulation.

paste(starwars, c("jedi", "jedi master", "wookie", "sith",
                  "sith lord"), sep = ": ")

paste(c("one", "two", "red", "blue", "fish"), collapse = ", ")

cards <- paste(rep(c(2:10, "J", "Q", "K", "A"), each = 4),
               c("C", "D", "H", "S"), sep = "")


## Vector indexing begins at 1, not 0.

deck[1]

deck[c(1,3,2)]   # use numeric vectors for multiple index selection
deck[c(-1,-2)]   # use negative numbers to specify indices to exclude

deck[c(T, F, F, T, T)]    # (T = keep, F = exclude)
deck[c(T, F)]             # NOTE: vector recycling

x[x > 3]                  # components of x that are > 3
which(x > 3)
x[which(x > 3)]

x[1:3]                    # the first 3 elements of x
x[c(1, 1, 1, 1)]          # the first component of x repeated 4 times

## The [] operator returns a reference to elements of the vector so we can
## modify the vector in place.

starwars[1] <- "luke skywalker"
starwars

w <- c(1, 0, -1, -3)
w[w < 0] <- -w[w < 0]     # same effect as w <- abs(w)


## What happens if we leverage "single-argument" functions over vectors?

x <- 1:10
sin(x)                    # componentwise evaluation


## Q: What does the following print?
## A: An reimann sum of f(x) = x^2 from 0 to 4. The smaller dx, the closer
##    an approximation this becomes.

dx <- .005
x <- seq(from = 0, to = 4, by = dx)
sum(x^2 * dx)




## Appendix: NA and NaN Values:
## ----------------------------

## When statistical data is unavailable or missing, we use the special
## value 'NA'. Operations on NA values result in NA values.

z <- c(1:3, NA)
z
z + 1

## The special function 'is.na(...)' will return a logical vector with
## TRUE indicating NA values.

is.na(z)        # c(FALSE, FALSE, FALSE, TRUE)
z[4] == NA      # FALSE

## A second kind of "missing" value is the so-called 'Not a Number', or NaN.

0/0
is.nan(0/0)




## Exercises:
## ----------

## 1) Make every odd number in x negative

x <- sample(-100:100, size = 100)   # random numeric vector with values between
                                    # -100 and 100

x[x %% 2 != 0] <- -x[x %% 2 != 0]


## 2) Take the dot product of x and y

x <- 1:100
y <- 100:1

sum(x * y)


## 3) Find the unit vector pointing in the same direction as x

x <- 1:50
x / sqrt(sum(x^2))
