DOC = "Build and plot the boys, girls, and the relative difference per year."
source("http://www.openintro.org/stat/data/present.R")
year = present$year
boy= present$boys

girl= present$girls

rel_boy =(boy+girl)/boy

rel_girl = (boy+girl)/girl

# Plotting data points from the Present data set.
par(mar = c(5,5,3,5))
plot(year,boy,type='l',ylab="boy and girl baptisms per year", 
     main="Present data, gendered baptisms plot",xlab='year',col='blue')
lines(year,girl,col='red')
par(new=TRUE)
# plot(year,bg_diff,type='l',xaxt='n',yaxt='n',ylab='',xlab='',lty=2)
plot(year, rel_girl,type='l',xaxt='n',yaxt='n',ylab='',xlab='',lty=2,col='orange')
lines(year,rel_boy         ,xaxt='n',yaxt='n',ylab='',xlab='',lty=2,col='purple')
axis(side=4)
mtext('difference in boys and girls yearly baptism count',side=4,line=3)
legend("right", c("boys", "girls","relative girl count","relative boy count"),
       col = c("blue", "red","orange","purple"), lty = c(1, 1, 2, 2))

plot(year, boy/girl,type='l',col='blue',ylim=c(.5,1.5))
lines(year, girl/boy,col='red')
lines(year,boy/boy)

pboy = boy
pgirl = girl
pyear = year

source("http://www.openintro.org/stat/data/arbuthnot.R")

year = arbuthnot$year
boy= arbuthnot$boys

girl= arbuthnot$girls

bg_diff = boy/max(boy+girl)

gb_diff = girl/max(boy+girl)
# plotting data points from the Arbothnot data set
par(mar = c(5,5,3,5))
plot(year,boy,type='l',ylab="boy and girl baptisms per year", 
     main="Arbothnot's data, gendered baptisms plot",xlab='year',col='blue')
lines(year,girl,col='red')
par(new=TRUE)
plot(year, gb_diff,type='l',xaxt='n',yaxt='n',ylab='',xlab='',lty=2,col='orange')
lines(year,bg_diff         ,xaxt='n',yaxt='n',ylab='',xlab='',lty=2,col='purple')
axis(side=4)
mtext('difference in boys and girls yearly baptism count',side=4,line=3)
legend("right", c("boys", "girls","girls/max(girls+boys)","boys/max(boys+girls)"),
       col = c("blue", "red","orange","purple"), lty = c(1, 1, 2,2))

plot(year, boy/girl,type='l',col='blue',ylim=c(.7,1.2))
lines(year, girl/boy,col='red')
lines(year,boy/boy)

plot(pyear,pgirl/pboy,type='l',ylim=c(-1.5,1.5),col="red",main="Boy to Girl Ratios for Present data")
par(new=TRUE)
plot(pyear, pboy/pgirl,type='b',xaxt='n',yaxt='n',ylab='',xlab='', col='blue')
lines(pyear,pgirl/pgirl,type='l',col="black")
legend("topright", c("girls", "boys"), col = c("red","blue"), lty = c(1, 1))

scatter.smooth(pyear,pboy/pgirl,col="blue",yli=c(1.03,1.065),main="present boy/presentt girl ratio scatter.smooth")
scatter.smooth(pyear, pgirl/pboy, col='red',yli=c(.9,1),main="present gir/presentt boy ratio scatter.smooth")



plot(year, girl/boy, type='b',yli=c(-1.5,1.5),col='orange', main="Boy to Girl Ratios for Arbuthnot's data")
par(new=TRUE)
plot(year,boy/girl,type='b',xaxt='n',yaxt='n',ylab='',xlab='',lty=2,col='purple')
# lines(year,boy/boy)
legend("topright", c("girls", "boys"),
       col = c("orange","purple"), lty = c(1, 1))

scatter.smooth(year, girl/boy,type='b',lty=2,yli=c(.8,1.1),col='orange',main="present gir/presentt boy ratio scatter.smooth")
scatter.smooth(year,boy/girl,type='b',lty=2,col='purple',yli=c(.9,1.2),main="present boy/presentt girl ratio scatter.smooth")

plot(arbuthnot)
plot(present)
x_axis =seq(1, length(present$year))
x_axis
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
