DOC = "
The Data
........

This week we'll be working with measurements of body dimensions. This data set contains measurements from 247 men and 
260 women, most of whom were considered healthy young adults.

download.file('http://www.openintro.org/stat/data/bdims.RData', destfile = 'bdims.RData')
load('bdims.RData')
Let's take a quick peek at the first few rows of the data.

  head(bdims)

You'll see that for every observation we have 25 measurements, many of which are either diameters or girths. A key 
to the variable names can be found at http://www.openintro.org/stat/data/bdims.php, but we'll be focusing on just 
three columns to get started: weight in kg (wgt), height in cm (hgt), and sex (1 indicates male, 0 indicates female).

Since males and females tend to have different body dimensions, it will be useful to create two additional 
data sets: one with only men and another with only women.

  mdims <- subset(bdims, sex == 1)
  fdims <- subset(bdims, sex == 0)

Exercise 1:

Make a histogram of men's heights and a histogram of women's heights. How would you compare the 
various aspects of the two distributions?
"
script_num = 1
script_intro(paste("Exercise",script_num))



prompt = "Make a histogram of men's heights and a histogram of women's heights. How would you compare the various 
aspects of the two distributions?"
cat(blue("Exercise "%+%red$bold(script_num) %+%":\n"), 
    magenta(prompt), sep="")


cat(green("\nhead(bdims)\n"))
print(head(bdims))

cat(green("\nmdims <- subset(bdims, sex == 1)\n"))
mdims <- subset(bdims, sex == 1)

cat(green("fdims <- subset(bdims, sex == 0)\n"))
fdims <- subset(bdims, sex == 0)

cat(blue("Exercise 1:\n\t"), 
    magenta("Make a histogram of men's heights and a histogram of women's heights. 
         \n\tHow would you compare the various aspects of the two distributions?\n"), sep="")

cat(green("\ndim(bdims)\n"))
print(dim(bdims))

cat(green("\nnames(bdims)\n"))
print(names(bdims))
ex1_plt_func <- function(src_data, uniq_label){
  DOC = "produces a barplot, with data labels at the top of each bar, where each bar represents a count of how many times a given height occurs in the population"
  
  y_ax_label="count of "%+%uniq_label%+%" at each height"
  x_ax_label="recorded"%+%uniq_label
  main_title="Histogram of "%+%uniq_label%+%" frequencies"
  hgt <- sort(src_data$hgt)
  uniq_hgt <- unique(hgt)
  # this next line will tabulate a count of how many times each distinct value occurs inside of hgt
  hgt_table <- tabulate(match(hgt, uniq_hgt))
  plot_df <- data.frame(hgt=uniq_hgt,counts=hgt_table)
  bar_labels <- plot_df$counts
  bar_labels[bar_labels<=1] <- "-"
  brplt <- barplot(height=plot_df$counts, 
                   width=plot_df$hgt, 
                   space=2,
                   ylim = c(0,1.4*max(plot_df$counts)),
                   ylab = y_ax_label,#"count of people at each height",
                   xlab = x_ax_label,#"measured heights",
                   main=main_title)
  text(x=brplt, y=plot_df$counts, label=bar_labels, pos=3, cex=.8, col='red')
}
cat(green("\nhist(mdims$hgt,probability = TRUE)\n"))
hist(mdims$hgt,probability = TRUE)
cat(green("hist(fdims$hgt,probability = TRUE)\n"))
hist(fdims$hgt,probability = TRUE)

script_outro(paste("Exercise",script_num))