## File: oop.R
## Author: John Rothfels (rothfels)
## Description: Object Oriented Programming in R
## ---------------------------------------------


## The entities R operates on are technically known as objects. To list
## the objects in your workspace, use 'objects' or 'ls'.

ls()

## If you need to get rid of objects, use rm()

x <- 1:10
ls()
rm(x)
rm(list = ls())       # removes everything


## Every object has certain intrinsic attributes. Two important intrinsic
## attributes are "mode" and "length". Mode is the type of an object,
## namely numeric, complex, logical, character, list, or raw.

vec <- 1:5
mode(vec)

strvec <- c(vec, "the components of 'vec' will be coerced to strings")
strvec
mode(strvec)

complexvec <- c(vec, 1+2i)
complexvec
mode(complexvec)

## Q: What will the following expressions evaulate to? See if you can guess.

c(TRUE, 1:5)
c(TRUE, "TRUE")
c(1, 1+0i, T, "TRUE")

## You can coerce the mode of a vector manually.

mode(vec) <- "complex"
vec
mode(vec) <- "character"
vec

## Alternatively, you can use the 'as' functions. This will not work on all
## objects, for instance if you try to cast a character vector to a numeric
## vector.

as.character(0:5)
as.complex(0:5)
as.logical(0:5)
as.numeric(c('a','b','c'))


## Empty objects still have a mode.

e <- numeric()
e[3] <- 17        # vector of length 3, first two components are NA

## Just as you can coerce mode, you may also change length

length(e) <- 1	  # you can extend 'e' similarly
e

## Every object belongs to a certain class. So far, we have looked in depth at
## vectors, but there are others. Depending on the mode of the vector, it will
## belong to one of various different classes.

class(1:5)
class(1)                  # NOTE: difference between 'integer' and 'numeric'
class(c('a', 'b', 'c'))
class(c(TRUE, FALSE))
class(as.logical(1:5))

##  Here are a few other types of objects we will be looking at in this course.

as.matrix(1:5)                  # class = "matrix"
as.list(1:5)                    # class = "list"
as.data.frame(1:5)              # class = "data frame"

## The 'is' family of functions can be used to test what class an object
## belongs to.

is.matrix(as.matrix(1:5))
is.list(as.matrix(1:5))

## Every class has certain "attributes". To access these attributes, use the
## 'attributes' function.

attributes(as.matrix(1:5))
dim(as.matrix(1:5))

attributes(as.data.frame(1:5))
row.names(as.data.frame(1:5))

## Creating objects of your own class is simple. Notice objects are
## initially printed strangely.

x <- 1:5
class(x) <- "MyClass"
x

## Set attributes with the 'attributes' or 'attr' functions.

attr(x, "foo") <- 3      # give the 'foo' attribute the value 3
attributes(x)

## Class methods in R are handled in one of two ways. You can have S3 objects
## or S4 objects. The former are simple, and the latter are incredibly
## complicated. We'll briefly take a look at the S3 methods. Remember how
## our new object prints strangely to the R consol? This is because the
## object's 'print' method has not been written, so R uses a default
## print function. To write a 'print' method for "MyClass" objects which
## will direct how objects are printed to the console we must write the
## function 'print.MyClass'. Its arguments should be the same as R's generic
## 'print' function.

args(print)
print.MyClass <- function(x, ...) {
  cat("hello world")
}

print(x)
x

## This is just a sample of R's object oriented behavior. For the purposes
## of this class, you will not need to know how to create classes or write
## S3/S4 methods.
