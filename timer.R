#
# Timer script
#

## Necessary libraries -----------

library(tictoc)

#Clearing tictoc log before executing
tic.clearlog()

## Time the execution of task 1 -----------

tic("Executing Task 1")
source("scripts/Task1.R")
toc(log = TRUE)

## Time the execution of task 2 -----------

tic("Executing Task 2")
source("scripts/Task2.R")
toc(log = TRUE)

## Time the execution of task31 -----------

tic("Executing Task 3")
source("scripts/Task3.R")
toc(log = TRUE)

## Output -----------

#Creating a function to compare the tasks (code from lecture)
printTicTocLog <-
  function() {
    tic.log() %>%
      unlist %>%
      tibble(logvals = .) %>%
      separate(logvals,
               sep = ":",
               into = c("Function type", "log")) %>%
      mutate(log = str_trim(log)) %>%
      separate(log,
               sep = " ",
               into = c("Seconds"),
               extra = "drop")
  }



printTicTocLog() %>%
  knitr::kable()


# OUtput from running the model
# |Function type    |Seconds |
#   |:----------------|:-------|
#   |Executing Task 1 |90.97   |
#   |Executing Task 2 |80.39   |
#   |Executing Task 3 |61.19   |


# Task 1 took the longest time of 90.97 seconds. 
# This was the original non-parallelized version of the script.

# Task 2 took 80.39 seconds. In this task, the main loop in the script was 
# parallelized, leading to a performance improvement over Task 1.

# Task 3 was the fastest, completing in 61.19 seconds. Here, the MTweedieTests 
# function was internally parallelized, allowing multiple simulations 
# to run concurrently. This granular level of parallelization proved to 
# be the most efficient approach.

# From the results, it's evident that leveraging parallel computing can 
# significantly improve the performance of computationally intensive tasks. 
# The degree of improvement depends on how the parallelization is applied. 
# In this case, parallelizing the MTweedieTests function proved to be the most 
# effective approach. This might be due to the more granular distribution of 
# computations, allowing better utilization of available cores.
