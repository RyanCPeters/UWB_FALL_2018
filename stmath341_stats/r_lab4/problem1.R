DOC = "

1) Now let's consider some of the other variables in the body dimensions data set. 
Using the figures at the end of the exercises, match the histogram to its normal probability plot. 
All of the variables have been standardized (first subtract the mean, then divide by the standard deviation), 
so the units won't be of any help. If you are uncertain based on these figures, generate the plots in 
R to check.

a. The histogram for female biiliac (pelvic) diameter (bii.di) belongs to normal probability plot letter ____.

b. The histogram for female elbow diameter (elb.di) belongs to normal probability plot letter ____.

c. The histogram for general age (age) belongs to normal probability plot letter ____.

d. The histogram for female chest depth (che.de) belongs to normal probability plot letter ____.

"
bii.di <- fdims$bii.di
elb.di <- fdims$elb.di
age <- fdims$age
che.de <- fdims$che.de
kne.di <- fdims$kne.di
hist_qq_plotter <- function(data,title=""){
  data_mean <- mean(data)
  data_sd <- sd(data)
  normalized <- (data-data_mean)/data_sd
  # sim_min <- min(data)
  # sim_max <- max(data)
  # x <- sim_min:sim_max
  # y <- dnorm(x = x, mean = data_mean, sd = data_sd)
  # hist(data, main=title%+%" Histogram", probability = TRUE, ylim = c(0, max(y)*1.3))
  # lines(x = x, y = y, col = 'blue', ylim=c(0, 1.1*max(y)))
  hist(normalized,main=title%+%" Histogram")
  qqnorm(normalized,ylim = c(min(normalized)*1.1, max(normalized)*1.1), main=title%+%" Normal Q-Q plot")
  qqline(normalized)
  
  # qqnormsim(normalized)
}



par(mfrow=c(3,2))# tells the compiler to put the next 6 images into a single plot window, in a grid of 3 rows by 2 columns
hist_qq_plotter(bii.di,"fdims$bii.di")
hist_qq_plotter(elb.di,"fdims$elb.di")
hist_qq_plotter(age,"fdims$age")
par(mfrow=c(2,2))# tells the compiler to put the next 4 imges into a single plot window, in a grid 
hist_qq_plotter(che.de,"fdims$che.de")
hist_qq_plotter(kne.di, "fdims$kne.di")


cat(green("fbiidimean <- mean(fdims$bii.di)\n"))
print(fbiidimean)
cat(green("fbiidisd <- sd(fdims$bii.di)\n"))
print(fbiidisd)
