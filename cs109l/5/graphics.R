## File: graphics.R
## Author: John Rothfels (rothfels)
## Description: Introduction to Graphics in R
## ------------------------------------------

## A brief introduction to the R graphics subsystem:

demo(graphics)

x <- 1:10

plot(x)
plot(x, x^2)

x <- -10:10
plot(x, x^3)
plot(x, x^3, type = 'p', pch = 'g')     # 'p' = points; 'pch' = plotting char
plot(x, x^3, type = 'l', col = 'blue')  # 'l' = lines

plot(x, x^3, type = 'l', lty = 'dotted')
plot(x, x^3, type = 'l', lty = 4)

plot(x, x^3, type = 'b', col = 'red')       # 'b' = both
plot(x, x^3, type = 'o', col = 'yellow')    # 'o' = overlay
plot(x, x^3, type = 'h', col = 'green')     # 'h' = histogram
plot(x, x^3, type = 's' , col = 'purple')   # 's' = step

## The 'curve' function allows you to plot continuous functions. The
## first argument must be a function over x, not a function declaration.

curve(sin(x), from=0,to = 2*pi)
curve(sin, from = 0, to = 2*pi)
curve(function(x) sin(x), from = 0, to = 2*pi)   # error

curve(sin, from = 0, to = 2*pi, main = "SIN/COS GRAPHS", col='blue')
curve(cos, from = 0, to = 2*pi, col = 'red', add = TRUE)

abline(h = 0, col = 'green')
abline(v = seq(0, 2*pi, by = pi/2))

v <- seq(0, 2*pi, by = .01)
lines(v, -sin(v), col = 'purple')


## In the graphics model that R uses, there is (for a single plot) a figure
## region containing a central plotting region surrounded by margins.
## Coordinates inside the plotting region are specified in data units
## (the kind generally used to label the axes). Coordinates in the margins
## are specified in 'lines of text' as you move in a direction perpendicular
## to a side of the plotting region but in data units as you move along the
## side. This is useful since you generally want to put text in the margins
## of the plot.

## A standard x-y plot has an x and a y title label generated from the
## expressions being plotted. You may, however, override these labels and
## also add two further titles, a main title above the plot and a subtitle
## at the very bottom, in the plot call.

x <- runif(50, 0, 2)
y <- runif(50, 0, 2)
plot(x, y, main = "Main Title", sub = "Subtitle", xlab = "x-label",
     ylab = "y-label")

## Inside the plotting region, you can place points and lines that are
## either specified in the plot() call or added later with points() and
## lines(). You can also place a text with:

text(.6, .6, "text at (.6,.6)")
abline(h = .6, v = .6)

## Here, the abline() call is just to show how the text is centered on the
## point (.6,.6). Normally, abline() plots the line y = ax + b when given
## 'a' and 'b' as arguments, but it can also be used to draw horizontal and
## vertical lines as shown.

x <- 1:10
plot(x, x + 5)
text(x, x + 5, paste(x, x + 5, sep = ','), pos = 4)

## The margin coordinates are used by the 'mtext' function. They can be
## used as follows:

for (side in 1:4) mtext(-1:4, side = side, at = .7, line = -1:4)
mtext(paste("side", 1:4), side = 1:4, line = -1, font = 2)

## The 'for' loop places the numbers -1 to 4 on corresponding lines in each
## of the four margins at an off-center position of .7 measured in user
## coordinates. The subsequent call places a label on each side, giving the
## side number. The argument font = 2 argument means that a boldface font is
## used. Notice that not all the margins are wide enough to hold all the
## numbers and that it is possible to use negative line numbers to place
## text within the plotting region.



## High-level plots are composed of elements, each of which can also be drawn
## separately. The separate drawing commands often allow finer control of the
## element, so a standard strategy to achieve a given effect is first to draw
## the plot without that element and add the element subsequently. As an
## extreme case, the following command will plot absolutely nothing.

plot(x, y, type = "n", xlab = "", ylab ="", axes = FALSE)

## The fact that nothing is plotted does not mean that nothing happened.
## The command sets up the plotting region and coordinate systems just as if
## it had actually plotted the data. To add the plot elements, evaluate the
## following:

points(x, y)
axis(1)
axis(2, at = seq(.2, 1.8, .2))
box()
title(main = "Main Title", sub = "Subtitle", xlab = "x-label",
      ylab = "y-label")


## The following functions add to existing plots rather than instantiating
## a new plotting region. This is similar to how curve(..., add = TRUE) works.

# points(x, y, ...)                  adds points
# lines(x, y, ...)                   adds line segments
# text(x, y, labels, ...)            adds text into the graph
# abline(a, b, ...)                  adds the line y=ax+b
# abline(h = y, ...)                 adds a horizontal line
# abline(v = x, ...)                 adds a vertical line
# polygon(x, y, ...)                 adds a closed and possibly filled polygon
# segments(x0, y0, x1, y1, ...)      draws line segments
# arrows(x0, y0, x1, y1)             draws arrows
# symbols(x, y, ...)                 draws circles, squares, thermometers, etc
# legend(x, y, legend, ...)          draws a legend
# title(main, sub, xlab, ylab, ...)  adds titles
# mtext(text, side, line, ...)       draws text in the margins
# axis(side, at, labels, ...)        adds an axis to the plot
# box(...)                           adds a box around the plot region

x <- seq(0, 2*pi, by = .01)
y <- sin(x)
plot(x, y)
polygon(c(x[1], x, x[length(x)]), c(0, y, 0), col = 'blue')


## As we have seen, the curve() function graphs an expression (in terms of x)
## and its 'add = TRUE' argument allows it to overplot an existing plot.
## So things are generally sut up correctly, but sometimes the top of the
## density function gets chopped off. The reason is of course that the height
## of the normal density played no role in the setting of the y-axis for the
## histogram. It will not help to reverse the order and draw the curve first
## and add the histogram because then the highest bars might get clipped.

## The solution is first to get hold of the magnitude of the y values for
## both plot elements and make the plot big enough to hold both:

h <- hist(x, plot = FALSE)              # do not plot the histogram just yet
ylim <- range(0, h$density, dnorm(0))
hist(x, freq = FALSE, ylim = ylim)
curve(dnorm(x), add = TRUE)



## Suppose the top 25 movies made the following gross receipts for a week:

receipts <- c(29.6, 28.2, 19.6, 13.7, 13.0, 7.8, 3.4, 2.0, 1.9, 0.7, 0.4, 0.4,
              0.3, 0.3, 0.3, 0.3, 0.3, 0.2, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1)
hist(receipts)
hist(receipts, probability = TRUE)
rug(jitter(receipts))

## The basic histogram has a predefined set of break points for the bins.
## If you want, you can specify the number of breaks or your own break points.

hist(receipts, breaks = 10)
hist(receipts, breaks = c(0, 1, 2, 3, 4, 5, 10, 20, max(receipts)))


## We can use histograms to get basic visual insight about all kinds of
## probability distributions.

## a) create a histogram of 500 random normal variables (mean = 0, sd = 1)
a <- hist(rnorm(500))

## b) create a histogram of 500 random normal variables (mean = 0, sd = 1)
##    with labels
b <- hist(rnorm(500), main = "Random Normal Variables: mean=0, sd=1",
     xlab = "value", ylab="# observations")

## c) create a histogram of 500 random  poisson variables (lambda = 20)
c <- hist(rpois(500, lambda = 20), main = "Random Poisson Variables: lambda=20",
          xlab = "value", ylab = "# observations")

## d) create a histogram of 500 random binomial variables (n = 20, p = .5)
d <- hist(rbinom(500, 20, .5), main = "Random Binomial Variables: n=20, p=.5",
     xlab = "value", ylab = "# observations")

## e) create a histogram of 500 random uniform variables (a = 0, b = 1)
e <- hist(runif(500), main = "Random Uniform Variables: a=0, b=1",
     xlab = "value", ylab = "# observations")

## f) now graph b, c, d, & e but place them all on a single 2x2 graph
op <- par(mfrow = c(2, 2))
plot(b)
plot(c)
plot(d)
plot(e)
par(op)


## Note above that the 'par' function sets up 'p'lot 'ar'guments which will
## persist during the remainder of your R session. By setting the 'op' variable
## in our call to 'par', we retain the 'o'riginal 'p'lot arguments which
## we can reset later. We won't speak much about 'par' because it is very
## complex, but it is often times the key to a successful plot.




## Let's go through a domain specific example: Enzyme Kinetics

x <- c(2.7, 5.4, 8.09, 10.8)
names(x) <- rep("[S] (uM)", 4)

y <- list()
y[["0 nM inhibitor"]] <- c(0.123, 0.179, 0.21, 0.226)
y[["25 nM inhibitor"]] <- c(0.104, 0.159, 0.195, 0.207)
y[["50 nM inhibitor"]] <- c(0.086, 0.139, 0.172, 0.187)

names(y)

ylim <- range(y[[1]], y[[2]], y[[3]])

## Plotting attributes:
colors <- c("red", "green", "blue")
lty <- 1:3
pch <- 1:3

plot(x, y[[1]], type = "n", xlab = "", ylab ="", ylim = ylim, axes = FALSE)
axis(1)
axis(2)
box()
title(main = "Michaelis Menten Plot",
      xlab = expression(paste("[S] (", mu, "M)")),
      ylab = expression(paste("V (", mu, "mol / min)")))

for (i in 1:3) {
  lines(x, y[[i]], type = 'o', lty = lty[i], pch = pch[i], col = colors[i])
}

legend(locator(1), names(y), cex = 0.75, col = colors, lty = lty, pch = pch)



ylim <- range(0, 1/y[[1]], 1/y[[2]], 1/y[[3]])

plot(1 / x, 1 / y[[1]], type = "n", xlab = "", ylab ="",
     xlim = range(-1/x, 1/x), ylim = ylim, axes = FALSE)
axis(1)
axis(2)
box()
title(main = "Lineweaver-Burk Plot",
      xlab = expression(paste("1/[S] (1 / ", mu, "M)")),
      ylab = expression(paste("1/V (min / ", mu, "mol)")))

for (i in 1:3) {
  x. <- 1/x
  y. <- 1/y[[i]]
  lines(x., y., type = 'p', lty = lty[i], pch = pch[i], col = colors[i])
  abline(lm(y. ~ x.), col = colors[i], lty = lty[i])
}

abline(v = 0, lty = "dotted")

legend(locator(1), names(y), cex = 0.75, col = colors, lty = lty, pch = pch)
