
# Details relating to crayon can be found at the creator's github repo for the package:
# https://github.com/r-lib/crayon
required_pkgs <- c("devtools", "crayon","foreach","doParallel")


# A custom function for use in ensuring that R-library dependencies for commands use in this script are met
# without forcing the user to reinstall those packages each time the script is called.
# this function was coppied from:
# https://stackoverflow.com/a/9341833/7412747
pkgTest <- function(x)
{
  DOC ="given a vector of package names, this function is used to confirm that everything
  is available and loaded as expected."
  # Regrading the conditional check of:
  # 	`!require(x,character.only = TRUE)`
  # `require(x, ...)` will return a boolean indicating if
  # the package-name saved to the variable `x` is installed.
  #		-- Note that `character.only = TRUE` tells the function
  #		   to explicitely reference the string that `x` points to.
  #		   Not the name of the variable itself, ie., a package named 'x'
  # If the package is not installed, require(x,...) 
  # will return false, but because we negate that result with `!`, 
  # we will see that it's true that we must enter the 
  # body of the if block.
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    # Now we sanity check the result of the operation to
    # confirm that the package was actually installed, else
    # we stop the script and explain why
    if(!require(x,character.only = TRUE)) stop(cat(x,"Package not found"))
  }

}

script_intro <- function(x){
  cat(bgGreen(black(bold("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"))))
  cat(green(bold("Beginning "%+%magenta$underline(x)%+%" output\n...........................\n")))
}

script_outro <- function(x){
  
  cat(red(bold("\n~~~~~~~~~~~~~~~~~~~~~~~ Script complete: "%+%magenta$underline(x)%+%" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")))
  cat(bgRed(black(bold("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"))))
}

pkgload <- function(req_pkg_list){
  DOC = "Given a vector of the caller's required packages, this function will test if the packages need to be dowloaded,
  downloading any that are missing, then it will load those packages in preperation for the caller's execution."
  # Here we are simply making sure that each of the required packages are 
  # loaded into this current session of R
  for( target_package in req_pkg_list){
    pkgTest(target_package)
    library(target_package, character.only=TRUE)
  }
}



color_legend <- function(x=NULL){
  color_choices <- list()
  color_choices$black <- 
    black("\tblack:\t\tIs just the standard data output text\n")
  color_choices$red <- 
    red("\tred:\t\tIs for alert messages\n")
  color_choices$green <- 
    green("\tgreen:\t\tDemonstrates the exact command which produces some body of output text\n")
  
  # the yellow color may or may not be used in any given exercise or problem script
  color_choices$yellow <- 
    yellow("\tyellow:\t\tIs for warning messages, allerting that something may negatively affect data outputs\n")
  color_choices$magenta <- 
    magenta("\tmagenta:\tHighligts parameters in examples, and special case outputs\n")
  color_choices$cyan <- 
    cyan("\tcyan:\t\tHighlights script flow messages.\n\t\t\tE.G., messages that show when a script ends or flows into another\n")
  color_choices$blue <-
    blue("\tblue:\t\tIs for drawing attention to example commands, these are demonstrations which aren't \n\t\t\tactually being executed in the script\n")
  
  
  if(is.null(x) || nchar(x) < 1){
    for(y in color_choices){
      cat(y,"\n")
    }
  }
  else{
    cat(color_choices[[x]],"\n")
  }
}

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(uniqv, v)))]
}


# hist_with_labels <- function(x,units="", ...) {
#   H <- hist(x, plot = FALSE)
#   labs <- paste(H$counts, units, sep="")
#   plot(H, freq = TRUE, labels = labs, ylim=c(0, 1.08*max(H$counts)),...)
# }