source("~/GitHub_Remotes/UWB_FALL_2018/stmath341_stats/r_lab3/lab3_prep_script.R")
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Exercise 1: 
# What does a streak length of 1 mean, i.e. how many hits and misses are in a streak of 1? 
# What about a streak length of 0?

cat(cyan("\n\nStarting exercise 1 outputs\n"))
kobe_streak <- calc_streak(kobe$basket)

# we can comment out commands that we don't want in the final product, but still want to 
# see as part the code-source in order to help understand the steps and mental process followed 
# when we were writing the code in the first place.
# print(kobe_streak)
# the barplot as called for in the lab write-up
barplot(table(kobe_streak))
# ylim does as you might guess, it uses a vector -- c(element1, element2, ... , elementN) -- to define
# the upper and lower bounds for the y-axis in the plot
k_strk_tbl <- table(kobe_streak)
strk_cnt <- barplot(k_strk_tbl, 
                    # xaxt='n' tells R not to plot the table's x axis 
                    # (we'll do it later via another command so we can add labels to top of bars)
                    # xaxt='n', 
                    ylim = c(0, 1.4*max(k_strk_tbl)), 
                    ylab="streak count", 
                    xlab = "streak length")
text(x=strk_cnt, 
     y=k_strk_tbl, 
     label=k_strk_tbl, 
     pos=3, 
     cex=.8, 
     col='red')

k_strk_rel <- k_strk_tbl/length(kobe_streak)
rel_freq <- barplot(k_strk_rel, 
                    # xaxt='n',
                    ylim = c(0, 1.2*max(k_strk_rel)), 
                    ylab = "relative frequency", 
                    xlab = "streak length")
text(x=rel_freq, 
     y=k_strk_rel, 
     label=k_strk_rel*100, 
     pos=3, cex=.8, 
     col='red')
# end of code specific to exercise 1
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~