DOC = "

Normal probabilities
....................

Okay, so now you have a slew of tools to judge whether or not a variable is normally distributed. 
Why should we care?

It turns out that statisticians know a lot about the normal distribution. Once we decide that a random 
variable is approximately normal, we can answer all sorts of questions about that variable related to 
probability. Take, for example, the question of, 'What is the probability that a randomly chosen young 
adult female is taller than 6 feet (about 182 cm)?' (The study that published this data set is clear to 
point out that the sample was not random and therefore inference to a general population is not suggested.
We do so here only as an exercise.)

If we assume that female heights are normally distributed (a very close approximation is also okay), we 
can find this probability by calculating a Z score and consulting a Z table (also called a normal
probability table). In R, this is done in one step with the function pnorm.

  1 - pnorm(q = 182, mean = fhgtmean, sd = fhgtsd)

Note that the function pnorm gives the area under the normal curve below a given value, q, with a given 
mean and standard deviation. Since we're interested in the probability that someone is taller than 182 cm,
we have to take one minus that probability.

Assuming a normal distribution has allowed us to calculate a theoretical probability. If we want to 
calculate the probability empirically, we simply need to determine how many observations fall above 
182 then divide this number by the total sample size.

sum(fdims$hgt > 182) / length(fdims$hgt)
Although the probabilities are not exactly the same, they are reasonably close. The closer that your 
distribution is to being normal, the more accurate the theoretical probabilities will be.

Exercise 6:

Write out two probability questions that you would like to answer; one regarding female heights and one 
regarding female weights. Calculate the those probabilities using both the theoretical normal distribution 
as well as the empirical distribution (four probabilities in all). Which variable, height or weight, had a 
closer agreement between the two methods?


"



script_num = 6
script_intro(paste("Exercise",script_num))
prompt = 
"Write out two probability questions that you would like to answer; one regarding female heights and one 
regarding female weights. Calculate the those probabilities using both the theoretical normal distribution 
as well as the empirical distribution (four probabilities in all). Which variable, height or weight, had a 
closer agreement between the two methods?"
cat(blue("Exercise "%+%red$bold(script_num) %+%":\n"), 
    magenta(prompt), sep="")



cat(green("print(1 - pnorm(q = 182, mean = fhgtmean, sd = fhgtsd))\n"))
print(1 - pnorm(q = 182, mean = fhgtmean, sd = fhgtsd))
cat(green("print(sum(fdims$hgt > 182) / length(fdims$hgt))"))
print(sum(fdims$hgt > 182) / length(fdims$hgt))

script_outro(paste("Exercise",script_num))