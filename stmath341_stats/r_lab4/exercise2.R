DOC = "
The normal distribution
.......................

In your description of the distributions, did you use words like bell-shaped or normal?
It's tempting to say so when faced with a unimodal symmetric distribution.

To see how accurate that description is, we can plot a normal distribution curve on top of a
histogram to see how closely the data follow a normal distribution. This normal curve should have
the same mean and standard deviation as the data. We'll be working with women's heights, so let's
store them as a separate object and then calculate some statistics that will be referenced later.

  fhgtmean <- mean(fdims$hgt)
  fhgtsd   <- sd(fdims$hgt)

Next we make a density histogram to use as the backdrop and use the lines function to overlay a
normal probability curve. The difference between a frequency histogram and a density histogram is
that while in a frequency histogram the heights of the bars add up to the total number of
observations, in a density histogram the areas of the bars add up to 1. The area of each bar can
be calculated as simply the height times the width of the bar. Using a density histogram allows us
to properly overlay a normal distribution curve over the histogram since the curve is a normal
probability density function. Frequency and density histograms both display the same exact shape;
they only differ in their y-axis. You can verify this by comparing the frequency histogram you
constructed earlier and the density histogram created by the commands below.

  hist(fdims$hgt, probability = TRUE)
  x <- 140:190
  y <- dnorm(x = x, mean = fhgtmean, sd = fhgtsd)
  lines(x = x, y = y, col = 'blue')

After plotting the density histogram with the first command, we create the x- and y-coordinates for
the normal curve. We chose the x range as 140 to 190 in order to span the entire range of fheight.
To create y, we use dnorm to calculate the density of each of those x-values in a distribution that
is normal with mean fhgtmean and standard deviation fhgtsd. The final command draws a curve on the
existing plot (the density histogram) by connecting each of the points specified by x and y.
The argument col simply sets the color for the line to be drawn. If we left it out, the line would
be drawn in black.

The top of the curve is cut off because the limits of the x- and y-axes are set to best fit the
histogram. To adjust the y-axis you can add a third argument to the histogram function:

  ylim = c(0, 0.06)

Exercise 2:

Based on the this plot, does it appear that the data follow a nearly normal distribution?

"
script_num = 2
script_intro(paste("Exercise",script_num))

cat(green("fhgtmean <- mean(fdims$hgt)\n"))
fhgtmean <- mean(fdims$hgt)
print(fhgtmean)
cat(green("fhgtsd <- sd(fdims$hgt)\n"))
fhgtsd  <- sd(fdims$hgt)
print(fhgtsd)
x <- 140:190
y <- dnorm(x = x, mean = fhgtmean, sd = fhgtsd)
hist(fdims$hgt, probability = TRUE, ylim=c(0,1.1*max(y)))
lines(x = x, y = y, col = 'blue', ylim=c(0, 1.1*max(fdims$hgt)))


cat(green("y <- dnorm(x = x, mean = fhgtmean, sd = fhgtsd)\n"))
cat(green("hist(fdims$hgt, probability = TRUE, ylim=c(0,1.1*max(y)))\n"))
cat(green("lines(x = x, y = y, col = 'blue')\n"))
prompt = "Based on the this plot, does it appear that the data follow a nearly normal distribution?"
cat(blue("Exercise "%+%red$bold(script_num) %+%":\n"), 
    magenta(prompt), sep="")


script_outro(paste("Exercise",script_num))
