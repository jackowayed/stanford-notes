## File: symbolic.R
## Author: John Rothfels (rothfels)
## Description: Symbolic Computation
## ----------------------------

## In R, there is a special object type for unevaluated calls/expressions.
## Although there is a subtle difference between the two, for our purposes
## we can treat a "call" and an "expression" as the same object.

a <- 2
a^3

quote(a^3)
class(quote(a^3))
eval(quote(a^3))

expression(a^3)
class(expression(a^3))
eval(expression(a^3))

## Because R can interpret unevaluated expressions, it can support symbolic
## computation, such as taking derivatives. The function to take a derivative
## is 'D'.

D(quote(a^3), "a")            # differentiate a^3 with respect to "a"
eval(D(quote(a^3), "a"))

## When using 'eval', we can provide a list of evaluation arguments by name.

eval(D(D(quote(b^3*a^3), "a"), "b"), list(a = 10, b = 1))

deriv <- function(a) {
  return(eval(D(quote(a^3), "a")))
}

deriv(50)
deriv(100)

sapply(1:10, deriv)


## Suppose we want a function which works like 'deriv' above. That is, it
## takes a single argument, 'a', and computes a deriviative of some function
## of 'a' and evaluates it at the specified value. Since the function
## operates over a single argument, we should be able to apply it over a
## numeric vector the same way we have done above. To generalize our function,
## however, we would like to be able to decide when we call 'sapply' what
## expression we will be taking the derivitave of. In other words, we do *not*
## want to have this hardcoded in the function. For instructional purposes,
## let's pretend that 'sapply' cannot accept a ... argument to pass into
## the supplied function. How can we solve this problem.

## The solution is to use a lambda expression.

deriv <- function(expr) {
  return(function(a) eval(D(expr, "a")))
}

sapply(1:10, deriv(quote(a^2)))
sapply(1:10, deriv(quote(a^3)))
