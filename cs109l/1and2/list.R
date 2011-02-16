## File: list.R
## Author: John Rothfels (rothfels)
## Description: R List Object
## --------------------------


## In R, a "list" is a generic container for other objects. Like vectors,
## lists contain an ordered arrangement of elements. Unlike vectors, the
## elements of lists can be any type of object, including other lists. The
## mode of a list is 'list', which is to say that a list has no unified
## "type" of element like a vector stores only "numeric" data. Lists are
## created with the 'list' function.
## If you have the "Hmisc" package, you can use the 'list.tree' function
## to pretty print a summary of any list object. A similar version
## that ships with R is 'str'. You may use this if you find the default list
## print method to be hard to read.

mylist <- list("one", TRUE, 3, c("f", "o", "u", "r"), sin, list())
str(mylist)

library(Hmisc)
list.tree(mylist)    # this is particularly useful to visualize nested lists

## Single brackets are used to select a sublist; double brackets are used to
## extract single elements at a time.

mylist[2:3]
mylist[2]
mylist[[2]]

mylist[[4]][1]
mylist[4][1]

## The elements of a list can be named when the list is created:

mylist <- list(a = 1, b = c(TRUE, FALSE))
mylist
names(my.list)      # 'names' is an attribute of the list class

## We may then index the list as follows:

mylist$a            # same as my.list[[1]] or my.list[["a"]]

## To flatten a list (convert it to a vector containing the atomic components
## of the list) we use the 'unlist' function. This can be tricky and requires
## some getting used to.

x <- list(list(1, 2:3), 4:6)
unlist(x)
unlist(x, recursive = FALSE)   # removes one level from each element


## Lists allow us to create a C++ "struct" analog as follows.

x <- list()
x$field.one <- "val1"
x$field.two <- 1:5
x$fun <- sin

x$fun(x$field.two)

## We can combine lists together using 'c'.

x <- list(1, 2, 3)
y <- list(4, 5, 6)
c(x, y)
c(x, list(list(1), 2, 3))

## Note that arithmetic operators do not work for lists, nor do
## "vectorized" functions. The following three lines will raise errors.

x + y
x * y
prod(x)
