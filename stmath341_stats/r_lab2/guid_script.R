df_name <- 'cdc'
# instead of forcing the script to reload the dataframe every time we run it, lets do a quick check to see if it's already
# been instantiated from a previsou run
if (exists(df_name)) is.data.frame(get(df_name)) else source("http://www.openintro.org/stat/data/cdc.R")

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

gendered_weight_plots <- function(data, gender_str){
  cat('\n\n')
  data_len = length(data$weight)
  actual_w <- data$weight
  des_w <- data$wtdesire
  actual_w <- sort(actual_w)
  des_w <- sort(des_w)
  desired_tabs <- tabulate(match(des_w, unique(des_w)))
  actual_tabs <- tabulate(match(actual_w, unique(actual_w)))
  plot(unique(actual_w),type='l', actual_tabs/data_len, col='red', main=paste0(gender_str," line chart for actual and desired weights") )
  par(new=TRUE)
  plot(unique(des_w), desired_tabs/data_len,type = 'l',xaxt='n',yaxt='n',ylab='',xlab='', col='blue')
  legend("topright", c("actual weights by frequency", "desired weights by frequency"),
         col = c("red", "blue"), lty = c(1, 1,1,1))
  barplot(desired_tabs/data_len,col='blue', main=paste0(gender_str," bar chart for actual and desired weights"))
  par(new=TRUE)
  barplot(actual_tabs/data_len,col='red',xaxt='n',yaxt='n',ylab='',xlab='')
  legend("topright", c("actual weights by frequency", "desired weights by frequency"),
         col = c("red", "blue"), lty = c(1, 1,1,1))
  cat('\n\n')
  
}

cat("\nsummary for height:\n")
h_summ <- summary(cdc$height)
print(h_summ)
h_iqr = h_summ[[5]]-h_summ[[2]]
cat('\nheight iqr = ', h_iqr, "\n")
cat("\nsummary for age:\n")
ag_summ <- summary(cdc$age)
print(ag_summ)
age_iqr = ag_summ[[5]]-ag_summ[[2]]
cat('\nage iqr = ', age_iqr, "\n")
cat('\n\n')

g_exer <- table(cdc$gender, cdc$exerany)
cat("exerany by gender\n")
print(g_exer)
print(g_exer/20000)
mosaicplot(g_exer/20000)
cat("\n\n")

gender_smoke <- table(cdc$gender,cdc$smoke100)
cat("smoke100 by gender\n")
print(gender_smoke)
print(gender_smoke/20000)
cat('\n\n')
cat("There are ",sum(cdc$gender=='m'), "males in the study\n")
cat(sum(cdc$genhlth=='excellent'),"people report being in excellent health.\n")

mosaicplot(table(cdc$gender,cdc$smoke100))
mosaicplot(table(cdc$gender,cdc$smoke100)/20000)
mosaicplot(cdc$height ~ cdc$gender)
cat('\n\n')
under23_and_smoke <- subset(cdc, cdc$age < 23 & cdc$smoke100==1)
print(summary(under23_and_smoke))
cat('\n\nbmi~cdc$genhlth\n')

bmi <- (cdc$weight / cdc$height^2) * 703
boxplot(bmi ~ cdc$genhlth, main="bmi~cdc$genhlth")
print(summary(table(bmi, cdc$genhlth)))
cat('\n\nbmi~cdc$gender\n')
boxplot(bmi~cdc$gender, main="bmi~cdc$gender")
print(summary(table(bmi, cdc$gender)))
cat('\n\nbmi~cdc$smoke100\n')
boxplot(bmi ~ cdc$smoke100, main="bmi~cdc$smoke100")
print(summary(table(bmi, cdc$smoke100)))
cat('\n\n')
actual_w <- cdc$weight
des_w <- cdc$wtdesire
actual_w <- sort(actual_w)
des_w <- sort(des_w)
desired_tabs <- tabulate(match(des_w, unique(des_w)))
actual_tabs <- tabulate(match(actual_w, unique(actual_w)))
plot(unique(actual_w),type='l', actual_tabs/20000, col='red' )
par(new=TRUE)
plot(unique(des_w), desired_tabs/20000,type = 'l',xaxt='n',yaxt='n',ylab='',xlab='', col='blue')
legend("topright", c("actual weights by frequency", "desired weights by frequency"),
       col = c("red", "blue"), lty = c(1, 1,1,1))
barplot(desired_tabs/20000,col='blue')
par(new=TRUE)
barplot(actual_tabs/20000,col='red',xaxt='n',yaxt='n',ylab='',xlab='')
legend("topright", c("actual weights by frequency", "desired weights by frequency"),
       col = c("red", "blue"), lty = c(1, 1,1,1))
cat('\n\n')

men_weights <- subset(cdc, cdc$gender=='m')
fem_weights <- subset(cdc,cdc$gender=='f')

boxplot(men_weights$weight~men_weights$wtdesire,col='blue', main="weight vs wtdesire for men and women")

boxplot(fem_weights$weight~fem_weights$wtdesire,xaxt='n',yaxt='n',ylab='',xlab='', col='red')
gendered_weight_plots(men_weights,'male')
gendered_weight_plots(fem_weights, 'female')
cat("males summary\n")
print(summary(cdc[which(cdc$gender=='m'),6:7]))
cat("\n\nfemales summary\n")
print(summary(cdc[which(cdc$gender=='f'),6:7]))
cat("\n\nCalculated values for cdc$weight:")

variance <- var(cdc$weight)
mean_val <- mean(cdc$weight)
med <- median(cdc$weight)
std_dev <- sqrt(variance)
cat("\nvariance = ",variance,"\nmean = ",mean_val,"\nmedian = ",med,"\nstandard deviation = ",std_dev,"\n")
data_sub <- subset(cdc, cdc$weight> mean_val-std_dev & cdc$weight < mean_val+std_dev)
cat("\nSummary for the subset of the cdc data frame where only cases that have wheights that satisfy: mean-std_dev < x < mean+std_dev")
summary(data_sub)
cat("\n\nthe number of cases in this subset, divided by the number of cases in the cdc dataframe is: ", dim(data_sub)[1]/dim(cdc)[1],"\n")

cat("Script completed!!\n")