DOC = "
Evaluating the normal distribution
..................................

Eyeballing the shape of the histogram is one way to determine if the data appear to be nearly normally distributed, 
but it can be frustrating to decide just how close the histogram is to the curve. An alternative approach involves 
constructing a normal probability plot, also called a normal Q-Q plot for 'quantile-quantile'.

  qqnorm(fdims$hgt)
  qqline(fdims$hgt)

A data set that is nearly normal will result in a probability plot where the points closely follow the line. Any 
deviations from normality leads to deviations of these points from the line. The plot for female heights shows points 
that tend to follow the line but with some errant points towards the tails. We're left with the same problem that we 
encountered with the histogram above: how close is close enough?

A useful way to address this question is to rephrase it as: what do probability plots look like for data that I know 
came from a normal distribution? We can answer this by simulating data from a normal distribution using rnorm.

  sim_norm <- rnorm(n = length(fdims$hgt), mean = fhgtmean, sd = fhgtsd)

The first argument indicates how many numbers you'd like to generate, which we specify to be the same number of heights 
in the fdims data set using the length function. The last two arguments determine the mean and standard deviation of the
normal distribution from which the simulated sample will be generated. We can take a look at the shape of our simulated
data set, sim_norm, as well as its normal probability plot.

Exercise 3:

Make a normal probability plot of sim_norm. Do all of the points fall on the line? How does this plot compare to the
probability plot for the real data?
"
script_num = 3
script_intro(paste("Exercise",script_num))

cat(green("fhgtmean <- mean(fdims$hgt)\n"))
fhgtmean <- mean(fdims$hgt)
print(fhgtmean)
cat(green("fhgtsd <- sd(fdims$hgt)\n"))
fhgtsd  <- sd(fdims$hgt)
print(fhgtsd)

cat(green("qqnorm(fdims$hgt)\n"))
qqnorm(fdims$hgt)
cat(green("qqline(fdims$hgt)\n"))
qqline(fdims$hgt)
cat(green("sim_norm <- rnorm(n = length(fdims$hgt), mean = fhgtmean, sd = fhgtsd)\n"))
sim_norm <- rnorm(n = length(fdims$hgt), mean = fhgtmean, sd = fhgtsd)


prompt = 
  "Make a normal probability plot of sim_norm. Do all of the points fall on the line? 
How does this plot compare to the probability plot for the real data?"
cat(blue("Exercise "%+%red$bold(script_num) %+%":\n"), 
    magenta(prompt), sep="")

cat(green("sim_min <- min(sim_norm)\n"))
cat(green("sim_max <- max(sim_norm)\n"))
cat(green("x <- sim_min:sim_max\n"))
cat(green("y <- dnorm(x = x, mean = fhgtmean, sd = fhgtsd)\n"))
cat(green("hist(fdims$hgt, probability = TRUE, ylim=c(0,1.1*max(y)))\n"))
cat(green("lines(x = x, y = y, col = 'blue', ylim=c(0, 1.1*max(fdims$hgt)))\n"))
sim_min <- min(sim_norm)
sim_max <- max(sim_norm)
x <- sim_min:sim_max
y <- dnorm(x = x, mean = fhgtmean, sd = fhgtsd)
hist(sim_norm, probability = TRUE, ylim=c(0,1.1*max(y)))
lines(x = x, y = y, col = 'blue', ylim=c(0, 1.1*sim_max))

script_outro(paste("Exercise",script_num))
