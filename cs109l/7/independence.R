## File: independence.R
## Author: John Rothfels (rothfels)
## Description: Independent Random Variables
## -----------------------------------------

x <- runif(100000)
y <- runif(100000)

hist(x + y, freq = FALSE)

plot(density(x + y))

plot(density(rbinom(100000, 10, .5)))

plot(density(x ^ y))
hist(x ^ y, freq = FALSE, add = TRUE)

x <- runif(10000) + runif(10000)
y <- seq(0, 2, by = .1)

p <- sapply(y, function(val) mean(x <= val))
plot(p, type = 'l')

d <- sapply(y, function(val) mean(x <= val + .05 & x >= val - .05))
plot(d, type = 'l')
