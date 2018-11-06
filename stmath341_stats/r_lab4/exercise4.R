DOC = "
Even better than comparing the original plot to a single plot generated from a 
normal distribution is to compare it to many more plots using the following function. 
It may be helpful to click the zoom button in the plot window.

  qqnormsim(fdims$hgt)

Exercise 4:

Does the normal probability plot for fdims$hgt look similar to the plots created for 
the simulated data? That is, do plots provide evidence that the female heights are nearly normal?

"
script_num = 4
script_intro(paste("Exercise",script_num))

cat(green(""))
qqnormsim(fdims$hgt)



prompt = "Does the normal probability plot for fdims$hgt look similar to the plots created for 
the simulated data? That is, do plots provide evidence that the female heights are nearly normal?"
cat(blue("Exercise "%+%red$bold(script_num) %+%":\n"), 
    magenta(prompt), sep="")



script_outro(paste("Exercise",script_num))