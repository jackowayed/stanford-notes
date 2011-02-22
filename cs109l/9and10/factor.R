## File: factor.R
## Author: John Rothfels (rothfels)
## Description: Factor Objects
## ---------------------------

## Statisticians typically recognize three basic types of variables:
## numeric, ordinal, and categorical. Both ordinal and categorical variables
## take values from some finite set, but the set is ordered for ordinal
## variables. For example, in an experiment one might grade the level of
## physical activity as low, medium, or high, giving an ordinal measurement.
## An example of a categorical variable is hair color. In R, the data type
## for ordinal and categorical vectors is factor. The possible values of a
## factor are referred to as its "levels."

## There are two reasons for using factors. The first is that the behavior of
## many statistical models depends on the type of input and output variables,
## so we need some way of distinguishing numeric, ordinal, and categorical
## variables. The second is that factors can be stored very efficiently.

## To create a factor, we apply the function 'factor' to a vector. By default,
## the distinct values of the vector become the levels, or we can specify them
## manually using the optional 'levels' argument. We check whether or not an
## object is a factor using 'is.factor' and list its levels using 'levels'.

hair <- c("blond", "black", "brown", "brown", "black", "gray", "none")
is.character(hair)
is.factor(hair)

hair <- factor(hair)
levels(hair)             # arranged in lexicographic order: 10 < 2

hair
class(hair)
mode(hair)
table(hair)

as.numeric(hair)         # values represented internally as integers
as.vector(hair)

x <- factor(c(.8, 1.1, .7, 1.4, 0.9))
as.numeric(x)                           # does not recover x
as.numeric(levels(x))[x]                # does recover x
as.numeric(as.character(x))             # does recover x

## To create an ordered factor (ordinal variable) include the option
## 'ordered = TRUE' in the factor function.

phys.act <- c("L", "H", "H", "L", "M", "M")
phys.act <- factor(phys.act, levels = c("L", "M", "H"), ordered = TRUE)
is.ordered(phys.act)

phys.act[2] > phys.act[1]
