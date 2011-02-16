## File: quicksort.R
## Author: John Rothfels (rothfels)
## Description: Analysis of Quicksort
## ----------------------------------

## ulimit -s hard
## R --max-ppsize=500000

## The functions below implement the quicksort algorithm.

options(expressions = 500000)

N <- c(100000, 500000, 1000000, 5000000, 10000000)

vectors <- lapply(N, function(x) sample(x, x))
vectors[[1]]

time <- system.time(sort(vectors[[1]], method = "quick"))
names(time)
time["user.self"]
time[1]

results <- sapply(vectors, function(x) system.time(sort(x, method = "quick"))[1])
dump("results", file = "results.R")

## What's the problem with the above? We only run Quicksort once for each
## input size. Since Quicksort is randomized, presumably we can have some
## variation in the runtime even with the same input size. For better results
## we should run multiple trials for each input size. The code below runs
## ten trials for each input size. I've predone this before class.

vectors <- lapply(N, function(x) lapply(1:10, function(i) sample(x, x)))
results.quick <- sapply(vectors, function(x)
                        mean(sapply(x, function(trial)
                                    system.time(sort(trial, method = "quick"))[1])))
dump("results.quick", file = "results_quick.R")


## Let's analyze our results: we know Quicksort is O(n log n).

plot(N, results.quick, type = "l", col = "blue")

## To see our plot versus n*log(n), we would need our axes to be way screwed up.
## Let's find a factor which will allow us to view both plots on the same graph.

factor <- max(N) * log(max(N))/ max(results.quick)
curve(x * log(x) / factor, from = 0, to = max(N), col = "green", add = TRUE)

## This should look like a log curve
y <- results.quick / N
factor <- log(max(N)) / max(y)

plot(N, y, type = "o", col = "blue")
curve(log(x) / factor, from = 0, to = max(N), col = "green", add = TRUE)
