DOC = "
Does lab 5 set up and sequenced execution, FOR GREAT JUSTICE!
"

# lab_specific_utils, bellow, is a list of script names that are specifically useful to this lab only
lab_specific_utils <- c("lab4_specific_utils.R")
target_scripts_list <- c("exercise1.R", 
                         "exercise2.R", 
                         "exercise3.R",
                         "exercise4.R", 
                         "exercise5.R",
                         "exercise6.R",
                         "problem1.R")
this_lab_main_name <- "lab4_main.R"
parent_folder <- "r_lab4/"
tools_folder <- "shared_lab_tools/"
script_tools_list <- c("prep_script.R")

## This loop handles the chore of traversing the frame stack in search of the 
#  path string to where this script is sourced from.
for(f in sys.frames()){
  if(is.null(f$filename)) next()
  # cat("\ntypeof(f$filename)",typeof(f$filename),"\n")
  # cat("print(f$filename) ",f$filename,"\n")
  my_path <- as.character(f$filename)
  break
}

## If the idenfited string is empty, then something went wrong and we need to stop the script now.
if(nchar(my_path)<1){
  stop("Alert! Terminating script as We can't find the absolute path to  prep_script.R")
}

# here we build the absolute path to where the current lab's answer scripts are saved
my_path <- sub(this_lab_main_name,"",my_path)
# here we build the absolute path to where the general lab utility tools script is saved
set_up_folder <- paste(sub(parent_folder,"",my_path),tools_folder, sep="")

cat("\n\n")
for(prep in script_tools_list){
  source(paste(set_up_folder,prep,sep=""))
}
# pkgload is a custom script that's defined inside of the shared_lab_utils folder
pkgload(c("devtools","crayon"))

for(util in lab_specific_utils){
  source(paste(my_path,util,sep=""))
}

cat("\n\nmy_path =\t",blue(my_path),"\n")
cat("set_up_folder =\t", blue(set_up_folder), "\n")
# passing a vector of required package names into the pkgload() function, defined in 'prep_script.R'.
pkgload(c("devtools", "crayon"))

cat(blue(green$italic("\noohhh, ")%+%red$bold("pretty ")%+%underline("color\n")))

# Instead of forcing the script to reload the dataframe every time we run it, 
# lets do a quick check to see if it's already been instantiated from a 
# previsou run first
df_name <- 'bdims'
if (exists(df_name)) is.data.frame(get(df_name)) else{
  download.file('http://www.openintro.org/stat/data/ames.RData', destfile = 'ames.RData')
  load('ames.RData')
}



## This is where we actually start loading and executing the seperate solution scripts to the various
#  exercises and problems from the homework lab.
for(next_script in target_scripts_list){
  source(paste(my_path,next_script,sep=""))
}
cat("\nTo see what the different colors of text mean, you can call", blue("color_legend()"),green("\n\ncolor_legend()\n"))
color_legend()


cat(magenta("\n\nTo see a description for any of the 'key' terms associated with bdims, mdims, or fdmims, you can call:\n\t",
            blue('what_is("key")'),"\nWhere key is any of the valid strings listed under\n\t", blue("names(bdims)\n")))

cat("e.g.,", green('\nwhat_is("hgt")\n'))
what_is("hgt")

cat("\n\nlab4_main.R is completed")


