## File: hash.R
## Author: John Rothfels (rothfels)
## Description: Hash Simulation
## ----------------------------

## INITIALIZE THE HASH TABLE.  This functions sets up an empty hash table
## that can hold up to "size" keys.  The "step" argument specifies how
## collisions are handled.  If step is 1 (the default), a collision is
## handled by stepping to the next bucket, and the next, etc.  If "step"
## is greater than one and "hashstep" is TRUE, a second hash function is
## applied to the key to produce a number from one to "step", and this is
## used as the number of buckets to step forward after a collision.
##
## The hash table is stored in the global variable hash.table.  The global
## variables hash.size and hash.step are also set.  (Note that <<- is used
## to assign to global variables.)  The buckets in the hash table are
## initialized with the special "NA" value to indicate that they are empty.

hash.table.setup <- function(size, step = 1, hashstep = FALSE) {
  if (!is.numeric(size) || floor(size) != size || size < 2) {
    stop("Size of table must be an integer greater than one.")
  }

  if (!is.numeric(step) || floor(step) != step || step < 1) {
    stop("Step size for avoiding collisions must be a positive integer.")
  }

  if (step > 1 && any (size %% (2:(size - 1)) == 0)) {
    stop("Size of table must be a prime number when step isn't one.")
  }

  if (step >= size) {
    stop("Step must be less than the table size")
  }

  hash.size <<- size
  hash.step <<- step
  hash.hashstep <<- hashstep
  hash.table <<- rep(NA, size)

  return(invisible())  ## Return nothing visible
}


## LOOK UP A KEY IN THE HASH TABLE.  The key can be either a character
## string or an integer, but you can't put both types in the same table.  If
## the "add" argument is TRUE, the key will be added to the table if it is not
## already present.  If "add" is FALSE (the default), the key will not be
## added.  The value returned is a list with two elements.  The $found
## element is TRUE or FALSE according to whether the key was found in the
## table or not.  The $probes element is the number of buckets in the table
## that had to be examined when looking for the key.

hash.lookup <- function(key, add = FALSE) {
  ## Find the hash values for this key, used for the initial bucket, and
  ## for the number of buckets to step forward if there is a collision.
  h <- hash(key, c(hash.size, hash.step))

  place <- h[1]
  step <- h[2]

  if (!hash.hashstep) step <- hash.step

  ## Initialize the count of how many buckets we look at.
  probes <- 1

  ## Loop until the bucket we see is empty or contains the key we're looking
  ## for.
  while (!is.na(hash.table[place]) && hash.table[place] != key) {
    ## See if we've looked at every bucket.  If we're trying to add, then
    ## that means we don't have space for another key, otherwise we just
    ## get out of the loop

    if (probes == hash.size) {
      if (add) {
        stop("Hash table overflow.")
      }
      break
    }

    ## Add step to place, wrapping around to the start of the table if
    ## necessary.
    place <- place + step
    if (place > hash.size) {
      place <- place - hash.size
    }

    probes <- probes + 1
  }

  ## See if we've found the key.
  found <- !is.na(hash.table[place]) && hash.table[place] == key

  ## Add the key if we didn't find it, and we're supposed to.
  if (!found && add) {
    if (!is.na(hash.table[place])) {
      stop("There's some sort of bug in the the hash table functions!")
    }
    hash.table[place] <<- key
  }

  ## Return list of found indicator and number of probes.
  return(list(found = found, probes = probes))
}


## HASH FUNCTION USED ABOVE.  For character strings, we start by adding
## together codes for all the characters.  It seems that it's not possible
## to get ASCII codes out of R, so this is done the hard way.  The strings
## must contain only letters and digits.  For integer keys, we just use the
## integer directly.  In either case, we then take the value modulo the
## integers in "moduli" and add one (so the range of values is from one to
## the modulus).  If "moduli" is a vector with several numbers, we return
## several hash values.
##
## Don't worry about how the conversion from characters to codes is done
## below. The details are arcane and unimportant.

hash <- function(key, moduli) {
  if (length(key)!=1 || !is.character(key) && !is.numeric(key)) {
    stop("A key must be a single integer or string.")
  }

  if (is.character(key)) {
    key <- sum(charmatch(strsplit(key,"")[[1]],
     strsplit("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
     "")[[1]]))
  }

  return((key %% moduli) + 1)
}





hash.table.setup(197)
hash.table

sapply(sample(1:1000, 160), function(val) hash.lookup(val, add = TRUE))

hash.table
hash.lookup(100)
hash.lookup(100)$probes

sapply(sample(1:1000, 200), function(val) hash.lookup(val)$probes)
mean(sapply(sample(1:1000, 200), function(val) hash.lookup(val)$probes))

## Over 50 trials, create a hash table of capacity 197 containing 160 values
## between 1 and 1000, then look up 200 random values between 1 and 1000 and
## determine the number of probes made. This will return a matrix with
## 50 columns and 200 rows.
result <- sapply(1:50, function(i) {
  hash.table.setup(197)
  sapply(sample(1:1000, 160), function(val) hash.lookup(val, add = TRUE))
  sapply(sample(1:1000, 200), function(val) hash.lookup(val)$probes)
})

## For each of the 50 trials, see how many lookups needed 5 or more probes
## to be completed and sum these together.
apply(result, 2, function(col) sum(col >= 5))
sum(apply(result, 2, function(col) sum(col >= 5)))

sum(result > 1)
sum(result == 1)
sum(result >= 5)
mean(result)

## Do these plots remind you of anything?

hist(result)
plot(density(result))
plot(ecdf(result))


result <- sapply(1:50, function(i) {
  hash.table.setup(197, step = 5)
  sapply(sample(1:1000, 160), function(val) hash.lookup(val, add = TRUE))
  sapply(sample(1:1000, 200), function(val) hash.lookup(val)$probes)
})

sum(result > 1)
sum(result == 1)
sum(result >= 5)
mean(result)
hist(result)

result <- sapply(1:50, function(i) {
  hash.table.setup(197, step = 20)
  sapply(sample(1:1000, 160), function(val) hash.lookup(val, add = TRUE))
  sapply(sample(1:1000, 200), function(val) hash.lookup(val)$probes)
})

sum(result > 1)
sum(result == 1)
sum(result >= 5)
mean(result)
hist(result)

## Now let's try doing applying a hash function for our step.

result <- sapply(1:50, function(i) {
  hash.table.setup(197,step = 20, hashstep = TRUE)
  sapply(sample(1:1000, 160), function(val) hash.lookup(val, add = TRUE))
  sapply(sample(1:1000, 200), function(val) hash.lookup(val)$probes)
})

sum(result > 1)
sum(result == 1)
sum(result >= 5)
mean(result)
hist(result)


best.step <- sapply(1:20, function(step) {
  mean(sapply(1:25, function(i) {
    hash.table.setup(197, step = step, hashstep = TRUE)
    sapply(sample(1:1000, 160), function(val) hash.lookup(val, add = TRUE))
    sapply(sample(1:1000, 200), function(val) hash.lookup(val)$probes)
  }))
})

plot(best.step, type = 'o')

## Does it seem right to make our step size very large?

result <- sapply(1:50, function(i) {
  hash.table.setup(197,step = 196, hashstep = TRUE)
  sapply(sample(1:1000, 160), function(val) hash.lookup(val, add = TRUE))
  sapply(sample(1:1000, 200), function(val) hash.lookup(val)$probes)
})


## Going back to without hashing our step...yeah, bad times.

best.step <- sapply(1:20, function(step) {
  mean(sapply(1:25, function(i) {
    hash.table.setup(197,step = step)
    sapply(sample(1:1000, 160), function(val) hash.lookup(val, add = TRUE))
    sapply(sample(1:1000, 200), function(val) hash.lookup(val)$probes)
  }))
})

plot(best.step, type = 'o')
