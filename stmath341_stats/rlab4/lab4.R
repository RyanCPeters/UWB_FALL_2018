df_name <- 'kobe'
# instead of forcing the script to reload the dataframe every time we run it, lets do a quick check to see if it's already
# been instantiated from a previsou run
if (exists(df_name)) is.data.frame(get(df_name)) else{
  download.file("http://www.openintro.org/stat/data/kobe.RData", destfile = "kobe.RData")
  load("kobe.RData")
}

head(kobe)