source("~/GitHub_Remotes/UWB_FALL_2018/stmath341_stats/r_lab3/lab3_prep_script.R")

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Exercise 3:
# In your simulation of flipping the unfair coin 100 times, how many flips came up heads?

# creating a central reference variable for changing how many flips per sample we do
max_samples <- 1000 
# creating a central reference variable for changing how many batches of max_samples we should do
normalizing_loops <- 500 

cat(cyan("\n\nStarting exercise 3 outputs\n"))
outcomes <- c('heads', 'tails')
cat(blue("\noutcomes <- c('heads', 'tails')\n"),outcomes, sep="")
cat(blue("\nsample(outcomes, size=1, replace=TRUE)\n"),sample(outcomes, size=1, replace=TRUE),sep = "")
sim_fair_coin <- sample(outcomes, size=max_samples, replace=TRUE)
cat(blue("\nsim_fair_coin <- sample(outcomes, size="),max_samples,blue(", replace=TRUE)\n"),
    "sum(sim_fair_coin=='heads')",sum(sim_fair_coin=='heads'),"\n",
    red("sum(sim_fair_coin=='tails')"),sum(sim_fair_coin=='tails'),sep = "")
cat("\nNow lets check the look of several loops over that logic\n",red("\tdon't be surprised if this takes a moment to compute\n"))

coin_flips_func <- function(result_groups,sample_size,loop_limit, bias=c(.5, .5)){
  head_sum <- 0
  tail_sum <- 0
  #loops_desired <- 100
  for(loop in 0:loop_limit){
    sim_fair_coin <- sample(result_groups, size=sample_size, replace=TRUE, prob = bias)
    head_sum <- head_sum+sum(sim_fair_coin=='heads')
    tail_sum <- tail_sum+sum(sim_fair_coin=='tails')
    #cat(blue("\tsum(sim_fair_coin=='heads')"),blue(sum(sim_fair_coin=='heads')),"\n",
    #    red("\tsum(sim_fair_coin=='tails')"),red(sum(sim_fair_coin=='tails')),"\n",sep = "")
  }
  head_avg <- head_sum/loop_limit
  tail_avg <- tail_sum/loop_limit
  ret_val <- c(loop_limit,sample_size,head_avg, tail_avg,bias)
  ret_val
}

## The following few lines of code are adapted from a stackoverflow post regarding
# parallel computation in R. The link to that post follows:
# https://stackoverflow.com/a/38335697/7412747

# Parallel computation set up here is so that we can produce sufficiently large
# data sets such that we can make a meaningful inference about the behavior of hte
# random sampling being done in the sim_fair_coin object.

# setup parallel backend to use many processors
cores=detectCores()
cl <- makeCluster(cores[1]-1) #not to overload your computer
registerDoParallel(cl)
parallel_result_name = "fair_coin_data"
if (exists(parallel_result_name)) remove(list=parallel_result_name)

# now we build our fair coin distribution dataset
coin_data <- foreach(loops=as.integer(seq(1,normalizing_loops, length.out = 50)),
                     .combine = 'rbind',
                     .inorder = FALSE, 
                     .multicombine = TRUE ) %:%
  foreach(samples=as.integer(seq(10,max_samples, length.out = 50)), 
          .combine='rbind', 
          .inorder = FALSE, 
          .multicombine = TRUE) %dopar% {
            data_batch_fair <- coin_flips_func(result_groups=outcomes,
                                               sample_size=samples,
                                               loop_limit=loops)
            data_batch_unfair <- coin_flips_func(result_groups=outcomes,
                                                 sample_size=samples,
                                                 loop_limit=loops,
                                                 bias=c(.2,.8))
            result <- rbind(data_batch_fair,data_batch_unfair)
            
            result# this implicitly binds the data_batch to the ongoing fair_coin_data frame
          }
stopCluster(cl) # stop cluster so that the resources can be made available again to the system.
fair_coin_data <- subset(coin_data, coin_data[,5]==.5)
unfair_coin_data <- subset(coin_data, coin_data[,5]==.2)
unfair_coin_data <- data.frame("norm_loops"=unfair_coin_data[,1],"SampleSize"=unfair_coin_data[,2],
                               "Heads"=unfair_coin_data[,3],
                               "head_bias"=unfair_coin_data[,5],
                               "tails"=unfair_coin_data[,4], 
                               "tail_bias"=unfair_coin_data[,6], 
                               'abs_dif' = abs(unfair_coin_data[,3]-unfair_coin_data[,4]), 
                               'norm_abs_dif'=abs(unfair_coin_data[,3]-unfair_coin_data[,4])/unfair_coin_data[,2])
fair_coin_data <- data.frame("norm_loops"=fair_coin_data[,1],"SampleSize"=fair_coin_data[,2],
                             "Heads"=fair_coin_data[,3],
                             "head_bias"=fair_coin_data[,5],
                             "tails"=fair_coin_data[,4], 
                             "tail_bias"=fair_coin_data[,6], 
                             'abs_dif' = abs(fair_coin_data[,3]-fair_coin_data[,4]), 
                             'norm_abs_dif'=abs(fair_coin_data[,3]-fair_coin_data[,4])/fair_coin_data[,2])
# The following line sorts the data set, in ascending order, according to sample size then number of normalizing loops
fair_coin_data <- fair_coin_data[order(fair_coin_data[,2],fair_coin_data[,1]),]
unfair_coin_data <- unfair_coin_data[order(unfair_coin_data[,2],unfair_coin_data[,1]),]
plot(fair_coin_data)
plot(unfair_coin_data)
cat("\nFinished building finalMatrix\n")
cat(green("In order to explore the results of calculating larger data sets for how fair and unfair coin biases play out\nyou can call"),
    blue("plot(fair_coin_data)"),
    green("and"),
    blue("plot(unfair_coin_data)\n"))

# For futher investigation into the fair vs unfair data frames, you can manipulate the variables manually in the console
# Now, it's time to actually answer the question posed for exercise 3
sim_unfair_coin <- sample(outcomes, size = 100, replace = TRUE, prob = c(0.2, 0.8))
cat(blue("sim_unfair_coin <- sample(outcomes, size = 100, replace = TRUE, prob = c(0.2, 0.8))\n"))
cat(blue("\ntable(sim_unfair_coin)\n"),magenta(table(sim_unfair_coin)),"\n\n")

# end of code specific to exercise 3
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~