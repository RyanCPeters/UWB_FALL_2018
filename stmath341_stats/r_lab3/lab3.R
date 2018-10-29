DOC = "Produces information that's useful in answering the exercise questions at the start of STMATH 341's lab 3"
source("~/GitHub_Remotes/UWB_FALL_2018/stmath341_stats/r_lab3/lab3_prep_script.R")

# The following line shows absolutely nothing on the console, even though it 
# still does the associated computations before moving on with the next line in the script.
head(kobe) 
# This next line does the exact same thing, but by wrapping it in the print(...) function, we tell
# R to send the output to console.
print(head(kobe))
print(kobe$basket[1:9])
source("~/GitHub_Remotes/UWB_FALL_2018/stmath341_stats/r_lab3/exercise1.R")
source("~/GitHub_Remotes/UWB_FALL_2018/stmath341_stats/r_lab3/exercise2.R")
if(TRUE){
  source("~/GitHub_Remotes/UWB_FALL_2018/stmath341_stats/r_lab3/exercise3.R")
}

source("~/GitHub_Remotes/UWB_FALL_2018/stmath341_stats/r_lab3/exercise4.R")
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## 'On Your Own' 1:
# Describe the distribution of streak lengths. What is the typical streak length for this 
# simulated independent shooter with a 45% shooting percentage? How long is the player's longest 
# streak of baskets in 133 shots
cat(cyan("\n\nStarting 'on your own' problem 1 outputs\n"))

kobe_streak <- calc_streak(kobe$basket)
k_strk_tbl <- table(kobe_streak)
strk_cnt <- barplot(k_strk_tbl, 
                    # xaxt='n' tells R not to plot the table's x axis 
                    # (we'll do it later via another command so we can add labels to top of bars)
                    # xaxt='n', 
                    ylim = c(0, 1.4*max(k_strk_tbl)), 
                    ylab="streak count", 
                    xlab = "streak length",
                    main="barplot for Kobe shoot streaks")
text(x=strk_cnt, 
     y=k_strk_tbl, 
     label=k_strk_tbl, 
     pos=3, 
     cex=.8, 
     col='red')

other_streak <- calc_streak(sim_basket)
o_strk_tbl <- table(other_streak)
ostrk_cnt <- barplot(o_strk_tbl,
                    ylim = c(0, 1.4*max(o_strk_tbl)), 
                    ylab="other streak count", 
                    xlab = "other streak length",
                    main="barplot for simulated shooter")
text(x=ostrk_cnt, 
     y=o_strk_tbl, 
     label=o_strk_tbl, 
     pos=3, 
     cex=.8, 
     col='blue')


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

o_strk_rel <- o_strk_tbl/length(other_streak)
orel_freq <- barplot(o_strk_rel, 
                    ylim = c(0, 1.2*max(o_strk_rel)), 
                    ylab = "other relative frequency", 
                    xlab = "other streak length",
                    main="normalized barplot for simulated shooter")
text(x=orel_freq, 
     y=o_strk_rel, 
     label=o_strk_rel*100, 
     pos=3, cex=.8, 
     col='blue')


# end of code specific to 'On Your Own 1'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## 'On Your Own' 2:
#  If you were to run the simulation of the independent shooter a second time, how would you 
# expect its streak distribution to compare to the distribution from the question above? Exactly 
# the same? Somewhat similar? Totally different? Explain your reasoning.
cat(cyan("\n\nStarting 'on your own' problem 2 outputs\n"))


# end of code specific to 'On Your Own 2'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## 'On Your Own' 3:
# How does Kobe Bryant's distribution of streak lengths compare to the distribution of streak 
# lengths for the simulated shooter? Using this comparison, do you have evidence that the hot 
# hand model fits Kobe's shooting patterns? Explain.
cat(cyan("\n\nStarting 'on your own' problem 3 outputs\n"))


# end of code specific to 'On Your Own 3'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  