source("~/GitHub_Remotes/UWB_FALL_2018/stmath341_stats/r_lab3/lab3_prep_script.R")
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Exercise 2: 
# Describe the distribution of Kobe's streak lengths from the 2009 NBA finals. What was his 
# typical streak length? How long was his longest streak of baskets?
cat(cyan("\n\nStarting exercise 2 outputs\n"))
hit_len = length(kobe$basket[which(kobe$basket=='H')])
streak_hit_len = length(kobe_streak[which(kobe_streak!=0)])

mis_len = length(kobe$basket[which(kobe$basket=='M')])
streak_mis_len = length(kobe_streak[which(kobe_streak==0)])

total_len = length(kobe$basket)
streak_total_len = length(kobe_streak)

cat("\n\n")
cat(blue("length(kobe$basket[which(kobe$basket=='H')])/length(kobe$basket)\n"))
cat(hit_len,"/",total_len," = ",(hit_len/total_len),"\n", sep="")
cat(blue("length(kobe_streak[which(kobe_streak!=0)])/length(kobe_streak)\n"))
cat(streak_hit_len,"/",streak_total_len," = ",(streak_hit_len/streak_total_len),"\n", sep="")


cat("\n\n")
cat(blue("length(kobe$basket[which(kobe$basket=='M')])/length(kobe$basket)\n"))
cat(mis_len,"/",total_len," = ",(mis_len/total_len),"\n", sep="")
cat(blue("length(kobe_streak[which(kobe_streak==0)])/length(kobe_streak)\n"))
cat(streak_mis_len,"/",streak_total_len," = ",(streak_mis_len/streak_total_len),"\n", sep="")
# end of code specific to exercise 2
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~