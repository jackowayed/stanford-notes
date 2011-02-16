## File: lambda.R
## Author: John Rothfels (rothfels)
## Description: Anonymous Functions
## --------------------------------

## Instead of having to predefine functions, R allows the user to create
## "anonymous" functions for one-time use.

(function(x) return(x+1))(2)

## We can also write functions which take other functions as parameters.

(function(fun) return(fun(pi/2)))(sin)

## We can even write functions inside of functions.

(function(elem) (function(arg) arg + 1)(elem))(2)


## DIFFICULT QUESTION: What do the following lines of code compute?

(function(f) { function(x) f(f(x)) })(function(x) x^2)(4)

(function(f) { function(x) f(f(x)) })(sin)(.5)
