source("~/GitHub_Remotes/UWB_FALL_2018/stmath341_stats/r_lab3/lab3_prep_script.R")
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Exercise 4:
# What change needs to be made to the sample function so that it reflects a shooting percentage of 45%? 
# Make this adjustment, then run a simulation to sample 133 shots. 
# Assign the output of this simulation to a new object called sim_basket.
cat(cyan("\n\nStarting exercise 4 outputs\n"))
outcomes <- c("H","M")
sim_basket <- sample(outcomes,size=133, replace=TRUE,prob=c(.45,.55))
cat(blue("\nsim_basket <- sample(outcomes,size=133, replace=TRUE,prob=c(.45,.55))\n"))
cat(blue("\ntable(kobe$basket)\n"),magenta(table(kobe$basket)),"\n")
cat(blue("\ntable(sim_basket)\n"),magenta(table(sim_basket)),"\n")


# end of code specific to exercise 4
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~