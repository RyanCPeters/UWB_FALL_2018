DOC = "Build and plot the boys, girls, and the relative difference per year."
source("http://www.openintro.org/stat/data/present.R")
source("http://www.openintro.org/stat/data/arbuthnot.R")

# library("ggplot2")

plot(arbuthnot)
plot(present)
x_axis =seq(1, length(present$year))
x_axis
norm_arb_boys = (arbuthnot$boys/max(arbuthnot$boys))
norm_arb_girls = (arbuthnot$girls/max(arbuthnot$girls))
norm_arb_sh_boys = (arbuthnot$boys/max(arbuthnot$boys))[1:length(x_axis)]
norm_arb_sh_girls = (arbuthnot$girls/max(arbuthnot$girls))[1:length(x_axis)]
norm_pres_boys = present$boys/max(present$boys)
norm_pres_girls = present$girls/max(present$girls)

plot(x_axis, norm_pres_girls, type = 'l', ylim = c(0,1), col='red', main="normalized values for present and arbuthnot data")
par(new=TRUE)
lines(x_axis, norm_pres_boys, col='blue')
lines(x_axis, norm_arb_sh_girls, col='orange')
lines(x_axis, norm_arb_sh_boys, col='purple')

legend("bottomright", c("pres_girls", "pres_boys","arb_girls", "arb_boys"),
       col = c("red", "blue","orange","purple"), lty = c(1, 1,1,1))