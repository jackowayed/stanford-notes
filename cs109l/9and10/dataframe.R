## File: dataframe.R
## Author: John Rothfels (rothfels)
## Description: Dataframe Objects
## ------------------------------

## Imagine a forestry experiment in which we randomly select a number of
## plots and then from each plot select a number of trees. For each tree
## we measure its height and diameter (which are numeric), and also the
## species of tree (which is a character string). To represent a collection
## of data corresponding to multiple observations or experimental units,
## R uses the ubiquitous "dataframe" object.

## A dataframe is a list (as in the R object) of vectors restricted to be
## of equal length. Each vector -- or column -- corresponds to a "variable",
## and each row corresponds to a single observation or experimental unit.
## Each vector can be of any of the basic modes of object, so a dataframe
## (like a list) can store heterogenous data, though each variable is
## restricted to be of the same type.

## Large dataframes are usually read into R from a file, using the function
## read.table, which has the form:

## read.table(file, header = FALSE, sep = "")

?read.table

library(spuRs)
data(ufc)               # load the dataset
?ufc

head(ufc)               # examine the first 6 entries in the dataset
tail(ufc)

## Indexing a dataframe is nearly identical to indexing a list. Just
## remember that every dataframe is a list with every element a vector of
## equal length. R displays dataframes differently than lists, but treats
## them almost identically internally.

is.data.frame(ufc)
is.list(ufc)
mode(ufc)
class(ufc)

ufc[1]                  # dataframe with only the first column
ufc[c(1, 3)]            # dataframe with only the first and third columns
as.list(ufc[c(1, 3)])

ufc[[1]]                # the first column
ufc[, 1]                # selects the first column, matrix style
ufc[["plot"]]           # the first column, referred to by name
ufc$plot                # the first column

## Indexing by row works slightly differently.

ufc[1, ]                # dataframe of the first row
ufc[1:3, ]              # dataframe of the first three rows
ufc[1:3, 1]             # the first three values of the first column (vector)
ufc[1:3, 1:2]           # dataframe of first three rows, first two columns


## We can create dataframes from a collection of vectors in the workspace
## as follows:
##   data.frame(col1 = x1, col2 = x2, ..., df1, df2, ...)

## Here col1, col2, etc. are the column names (given as character strings
## without quotes) and x1, x2, etc. are vectors of equal length. The arguments
## df1, df2, etc. are dataframes, whose columns must be the same length as the
## vectors x1, x2, etc. Column names may be omitted, in which case R will use
## default names.

## Just as we were able to do with lists, we may add a column to a dataframes
## on the fly simply by naming it and giving it a value.

ufc$dummy <- seq_along(ufc$plot)
names(ufc)

## The function subset is a convenient tool for selecting the rows of a
## dataframe, especially when combined with the operator '%in%'.

3 %in% 1:5

fir.height <- subset(ufc, subset = species %in% c("DF", "GF"),
                     select = c(plot, tree, height.m))

## NOTE: for vectors x and y (of the same mode), the expression x %in% y
## returns a logical vector of the same length as x, whose i-th element is
## TRUE if and olny if x[i] is an element of y.

## To write a dataframe to a file we use the function write.table().

?write.table

## As a final note, R provides a convenience function attach() which allows
## you to refer to the variables of a dataframe without having to prefix the
## name of the dataframe.
## NOTE: when you attach a dataframe, its columns become variables in the
## workspace - modifying them will not change the data frame.

attach(ufc)
height.m
height.m[1] <- Inf                  # ufc is not changed
detach(ufc)

attach(faithful)
hist(eruptions, 15, prob = TRUE)
lines(density(eruptions)))
