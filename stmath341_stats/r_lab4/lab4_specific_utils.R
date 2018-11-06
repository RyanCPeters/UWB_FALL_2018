DOC = "This script serves as a place to put utility functionality unique to lab 4 that would
       otherwise polute the code in our solution scripts. By placing these utility tools here,
       we make it easier to read the code we've written for explicitly answering the homework."


## creating a key 
# bdims: A data frame with 507 observations on the following 25 variables.
key_descriptions <- list()
key_descriptions$bia.di <- "a numerical vector, respondent's biacromial diameter in centimeters"
key_descriptions$bii.di <- "a numerical vector, respondent's biiliac diameter (pelvic breadth) in centimeters"
key_descriptions$bit.di <- "a numerical vector, respondent's bitrochanteric diameter in centimeters"
key_descriptions$che.de <- "a numerical vector, respondent's chest depth in centimeters, measured between spine and sternum at nipple level, mid-expiration"
key_descriptions$che.di <- "a numerical vector, respondent's chest diameter in centimeters, measured at nipple level, mid-expiration"
key_descriptions$elb.di <- "a numerical vector, respondent's elbow diameter in centimeters, measured as sum of two elbows"
key_descriptions$wri.di <- "a numerical vector, respondent's wrist diameter in centimeters, measured as sum of two wrists"
key_descriptions$kne.di <- "a numerical vector, respondent's knee diameter in centimeters, measured as sum of two knees"
key_descriptions$ank.di <- "a numerical vector, respondent's ankle diameter in centimeters, measured as sum of two ankles"
key_descriptions$sho.gi <- "a numerical vector, respondent's shoulder girth in centimeters, measured over deltoid muscles"
key_descriptions$che.gi <- "a numerical vector, respondent's chest girth in centimeters, measured at nipple line in males and just above breast tissue in females, mid-expiration"
key_descriptions$wai.gi <- "a numerical vector, respondent's waist girth in centimeters, measured at the narrowest part of torso below the rib cage as average of contracted and relaxed position"
key_descriptions$nav.gi <- "a numerical vector, respondent's navel (abdominal) girth in centimeters, measured at umbilicus and iliac crest using iliac crest as a landmark"
key_descriptions$hip.gi <- "a numerical vector, respondent's hip girth in centimeters, measured at at level of bitrochanteric diameter"
key_descriptions$thi.gi <- "a numerical vector, respondent's thigh girth in centimeters, measured below gluteal fold as the average of right and left girths"
key_descriptions$bic.gi <- "a numerical vector, respondent's bicep girth in centimeters, measured when flexed as the average of right and left girths"
key_descriptions$for.gi <- "a numerical vector, respondent's forearm girth in centimeters, measured when extended, palm up as the average of right and left girths"
key_descriptions$kne.gi <- "a numerical vector, respondent's knee diameter in centimeters, measured as sum of two knees"
key_descriptions$cal.gi <- "a numerical vector, respondent's calf maximum girth in centimeters, measured as average of right and left girths"
key_descriptions$ank.gi <- "a numerical vector, respondent's ankle minimum girth in centimeters, measured as average of right and left girths"
key_descriptions$wri.gi <- "a numerical vector, respondent's wrist minimum girth in centimeters, measured as average of right and left girths"
key_descriptions$age <-    "a numerical vector, respondent's age in years"
key_descriptions$wgt <-    "a numerical vector, respondent's weight in kilograms"
key_descriptions$hgt <-    "a numerical vector, respondent's height in centimeters"
key_descriptions$sex <-    "a categorical vector, 1 if the respondent is male, 0 if female"

what_is <- function(x){
  cat(underline(blue("bdims$" %+% green(x) %+% ":")),"\n\t",key_descriptions[[x]] ,"\n")
}
