DOC = "Main execution script for being able to call a single script and generate correct outputs for all quesions to lab 4, in order"

target_scripts_list = c("exercise1.R", "exercise2.R")
this_lab_main_name = "lab4_main.R"
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

# 
my_path <- sub(this_lab_main_name,"",my_path)
set_up_folder <- paste(sub(parent_folder,"",my_path),tools_folder, sep="")
print(my_path)
print(set_up_folder)
for(prep in script_tools_list){
  source(paste(set_up_folder,prep,sep=""))
}

# passing a vector of required package names into the pkgload() function, defined in 'prep_script.R'.
pkgload(c("devtools", "crayon"))

cat(blue("\npretty color\n"))

# Instead of forcing the script to reload the dataframe every time we run it, 
# lets do a quick check to see if it's already been instantiated from a 
# previsou run first
df_name <- 'bdims'
if (exists(df_name)) is.data.frame(get(df_name)) else{
  download.file("http://www.openintro.org/stat/data/bdims.RData", destfile = "bdims.RData")
  load("bdims.RData")
}
color_legend <- function(x=NULL){
  color_choices <- list()
  color_choices$black <- black("\tblack: is just the standard data output text")
  color_choices$red <- red("\tred: is for alert messages")
  color_choices$green <- green("\tgreen: demonstrates the exact command which produces some body of output text")
  # the yellow color may or may not be used in any given exercise or problem script)
  color_choices$yellow <- yellow("\tyellow: is for warning messages, allerting that something may negatively affect data outputs")
  color_choices$blue <- blue("\tblue: is for drawing attention to example commands, these are demonstrations which aren't actually being executed in the script")
  color_choices$magenta <- magenta("\tmagenta: highligts parameters in examples, and special case outputs")
  color_choices$cyan <- cyan("\tcyan: flags script flow messages. E.G., messages that show when a script ends or flows into another")
  
  if(is.null(x) || nchar(x) < 1){
    for(y in color_choices){
      cat(y,"\n")
    }
  }
  else{
    cat(color_choices[[x]],"\n")
  }
}

for(next_script in target_scripts_list){
  source(paste(my_path,next_script,sep=""))
}
cat("\nTo see what the different colors of text mean, you can call", blue("color_legend()"),green("\n\ncolor_legend()\n"))
color_legend()

cat("\n\nlab4_main.R is completed")
# cat("\nparents: ")
# print(sys.parents())
# cat("\nframes: \n")
# # print(sys.frames())
# for(x in sys.parents()){
#   cat("x = ",x,"\n")
#   cat("\nnames(x) =\n")
#   print(names(sys.frame(x)))
#   cat("\n\n")
#   print(sys.frame(x)$srcfile)
# }
# 

