R-Lab 6
================

-   [Foundations for statistical inference - Confidence intervals](#foundations-for-statistical-inference---confidence-intervals)
    -   [Sampling from Ames, Iowa](#sampling-from-ames-iowa)
    -   [The data](#the-data)

Foundations for statistical inference - Confidence intervals
============================================================

Sampling from Ames, Iowa
------------------------

If you have access to data on an entire population, say the size of every house in Ames, Iowa, it's straight forward to answer questions like, "How big is the typical house in Ames?" and "How much variation is there in sizes of houses?". If you have access to only a sample of the population, as is often the case, the task becomes more complicated. What is your best guess for the typical size if you only know the sizes of several dozen houses? This sort of situation requires that you use your sample to make inference on what your population looks like.

The data
--------

In the previous lab, \`\`Sampling Distributions'', we looked at the population data of houses from Ames, Iowa. Let's start by loading that data set.

download.file("<http://www.openintro.org/stat/data/ames.RData>", destfile = "ames.RData") load("ames.RData") In this lab we'll start with a simple random sample of size 60 from the population. Specifically, this is a simple random sample of size 60. Note that the data set has information on many housing variables, but for the first portion of the lab we'll focus on the size of the house, represented by the variable Gr.Liv.Area.

population &lt;- ames$Gr.Liv.Area samp &lt;- sample(population, 60) Describe the distribution of your sample. What would you say is the "typical" size within your sample? Also state precisely what you interpreted "typical" to mean.

Would you expect another student's distribution to be identical to yours? Would you expect it to be similar? Why or why not?

Confidence intervals One of the most common ways to describe the typical or central value of a distribution is to use the mean. In this case we can calculate the mean of the sample using,

sample\_mean &lt;- mean(samp) Return for a moment to the question that first motivated this lab: based on this sample, what can we infer about the population? Based only on this single sample, the best estimate of the average living area of houses sold in Ames would be the sample mean, usually denoted as x¯ (here we're calling it sample\_mean). That serves as a good point estimate but it would be useful to also communicate how uncertain we are of that estimate. This can be captured by using a confidence interval.

We can calculate a 95% confidence interval for a sample mean by adding and subtracting 1.96 standard errors to the point estimate (See Section 4.2.3 if you are unfamiliar with this formula).

se &lt;- sd(samp) / sqrt(60) lower &lt;- sample\_mean - 1.96 \* se upper &lt;- sample\_mean + 1.96 \* se c(lower, upper) This is an important inference that we've just made: even though we don't know what the full population looks like, we're 95% confident that the true average size of houses in Ames lies between the values lower and upper. There are a few conditions that must be met for this interval to be valid.

For the confidence interval to be valid, the sample mean must be normally distributed and have standard error s/n?????????. What conditions must be met for this to be true? Confidence levels What does "95% confidence" mean? If you're not sure, see Section 4.2.2. In this case we have the luxury of knowing the true population mean since we have data on the entire population. This value can be calculated using the following command:

mean(population) Does your confidence interval capture the true average size of houses in Ames? If you are working on this lab in a classroom, does your neighbor's interval capture this value?

Each student in your class should have gotten a slightly different confidence interval. What proportion of those intervals would you expect to capture the true population mean? Why? If you are working in this lab in a classroom, collect data on the intervals created by other students in the class and calculate the proportion of intervals that capture the true population mean.

Using R, we're going to recreate many samples to learn more about how sample means and confidence intervals vary from one sample to another. Loops come in handy here (If you are unfamiliar with loops, review the Sampling Distribution Lab).

Here is the rough outline:

Obtain a random sample. Calculate and store the sample's mean and standard deviation. Repeat steps (1) and (2) 50 times. Use these stored statistics to calculate many confidence intervals. But before we do all of this, we need to first create empty vectors where we can save the means and standard deviations that will be calculated from each sample. And while we're at it, let's also store the desired sample size as n.

samp\_mean &lt;- rep(NA, 50) samp\_sd &lt;- rep(NA, 50) n &lt;- 60 Now we're ready for the loop where we calculate the means and standard deviations of 50 random samples.

for(i in 1:50){ samp &lt;- sample(population, n) \# obtain a sample of size n = 60 from the population samp\_mean\[i\] &lt;- mean(samp) \# save sample mean in ith element of samp\_mean samp\_sd\[i\] &lt;- sd(samp) \# save sample sd in ith element of samp\_sd } Lastly, we construct the confidence intervals.

lower\_vector &lt;- samp\_mean - 1.96 \* samp\_sd / sqrt(n) upper\_vector &lt;- samp\_mean + 1.96 \* samp\_sd / sqrt(n) Lower bounds of these 50 confidence intervals are stored in lower\_vector, and the upper bounds are in upper\_vector. Let's view the first interval.

c(lower\_vector\[1\], upper\_vector\[1\]) On your own Using the following function (which was downloaded with the data set), plot all intervals. What proportion of your confidence intervals include the true population mean? Is this proportion exactly equal to the confidence level? If not, explain why.

plot\_ci(lower\_vector, upper\_vector, mean(population)) Pick a confidence level of your choosing, provided it is not 95%. What is the appropriate critical value?

Calculate 50 confidence intervals at the confidence level you chose in the previous question. You do not need to obtain new samples, simply calculate new intervals based on the sample means and standard deviations you have already collected. Using the plot\_ci function, plot all intervals and calculate the proportion of intervals that include the true population mean. How does this percentage compare to the confidence level selected for the intervals?

This is a product of OpenIntro that is released under a Creative Commons Attribution-ShareAlike 3.0 Unported. This lab was written for OpenIntro by Andrew Bray and Mine Çetinkaya-Rundel.
