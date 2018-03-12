#To setup the same global environment:

#Load the tidyverse library for better organizatin of data.
library(tidyverse) 

#Load the sample data
AlgaeSample1<-read_csv("AlgaeSample1.csv")
AlgaeSample2<-read_csv("AlgaeSample2.csv")

get_OH_signal <- function (sampledata) {
  #once again, we're going to separate the data from the instrument settings
  
  sliced <- slice(sampledata, 56:6056)
  
  #rename the columns
  renamed <- sliced %>% rename(Wavenumbers = 'PE IR       SPECTRUM    SPECTRUM    ASCII       PEDS        1.60',
                               Absorbance = X2 )
  
  #now, we're going to do the same thing we did with the carbonyl signal
  
  #the -OH signal is broad so we'll want wavenumbers 3300 +/-100
  
  carbohydrate_upper <-which (renamed ==3400)
  carbohydrate_lower <-which (renamed ==3200)
  carbohydrate_signal <- slice(renamed, carbohydrate_upper:carbohydrate_lower)
  return (carbohydrate_signal) 
}
#now that the function is loaded, we can insert our sample data and then save it as data, for example:
OH_signal_1<-get_OH_signal(AlgaeSample1)

