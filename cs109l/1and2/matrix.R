## File: matrix.R
## Author: John Rothfels (rothfels)
## Description: R Matrix Object
## ----------------------------


## When describing multi-dimensional data, you may use R's array ("matrix")
## object. You can instantiate a matrix in one on many ways, a few of which
## we will describe below.

matrix <- 1:30           # initialize matrix to be a vector
dim(matrix) <- c(5, 6)   # add a 'dim' (dimension) attribute to create a matrix
matrix

## Accessing elements of a matrix can be done with square brackets, separating
## dimension indices by ','. Omitting an index indicates that the full
## dimension should be taken.

matrix[2, 2]
matrix[2, ]

## To access multiple rows and colums, index by vector. Notice we can
## write to entire sub-matrices with single values.

matrix[2:3, c(1, 4)] <- 0

## You can change the dimension of a matrix on the fly so long as your matrix
## will contain an element at every index.

dim(matrix) <- c(3, 5, 2)
matrix

## Note that the values of a matrix appear in "column major order" with the
## first subscript moving fastest and the last subscript slowest.
## For example, the following would be the ordering of a 3x5x2 matrix 'a':
## a[1,1,1], a[2,1,1], ... , a[1,2,1], a[2,2,1], ... , a[2,5,2], a[3,5,2]

## You can perform componentwise arithmetic on matrices.

matrix + 1
matrix * 3

## Since the matrix is represented internally as a vector, we can access its
## elements like we would a vector. Be careful to note which values you
## are actually accessing from the matrix (see above note on "column
## major order").

matrix[1:4]
as.vector(matrix)
(as.vector(matrix))[1:4]


## We can also create matrices using other functions: 'rbind' for "rowbind",
## 'cbind' for "columnbind", and 'matrix' which offers a great amount of
## flexibility.

rbind(1:3, 2:4)
cbind(1:3, 2:4)

A <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)   # NOTE: "row major order"

## These functions (and many others) work on matrices. There are also a
## substantial number of linear operators built into R which may be useful
## (e.g. matrix multiplication).

nrow(A)
ncol(A)
det(A)      # determinant
t(A)        # transpose




## Exercises:
## ----------

## 1) Consider the one-player puzzle where you're presented with a 2 by n
##    board of small positive integers, like the following:
##      | 5 | 7 | 1 | 8 | 4 | 8 | 2 | 6 | 2 | 1 | 1 | 5 | 1 |
##      -----------------------------------------------------
##      | 7 | 1 | 3 | 3 | 4 | 9 | 6 | 1 | 5 | 9 | 2 | 3 | 2 |
##    Suppose that you are given an unlimited number of pebbles, and your
##    task is to distribute pebbles across the board (with at most one pebble
##    per square) subject to the constraint that you can't place pebbles in
##    vertically, horizontally, or diagonally adjacent locations. Your score
##    is the sum of all the values inside the squares covered by pebbles.
##
##    Write the function 'max.game.score' which, given a 2 by n matrix,
##    returns the maximum game score that can be achieved by playing the game
##    specified above.

max.game.score <- function(board) {
  ## Returns the maximum game score achievable on 'board'.
}

## > max.game.score(matrix(1:20,nrow=2,ncol=10))
## [1] 60
