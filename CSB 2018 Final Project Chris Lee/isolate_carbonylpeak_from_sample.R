#To setup the same global environment:

#Load the tidyverse library for better organizatin of data.
library(tidyverse) 

#Load the sample data
AlgaeSample1<-read_csv("AlgaeSample1.csv")


get_carbonyl_signal <- function (sampledata) {
  #once again, we're going to separate the data from the instrument settings
  
  sliced <- slice(sampledata, 56:6056)
  
  #rename the columns
  renamed <- sliced %>% rename(Wavenumbers = 'PE IR       SPECTRUM    SPECTRUM    ASCII       PEDS        1.60',
                               Absorbance = X2 )
  #slice/isolate the data we want
  
  #now, we're going to slice/isolate the data we want corresponding to lipids/carbonyls
  
  #the carbonyl/lipid signal we want will be around wavenumber 1700 +/-50.
  #first we're going to use the which function to find the indices we want from our data
  lip_upper <-which (renamed ==1750)
  lip_lower <-which (renamed ==1650)
    
  #then, we're going to slice the data we want using these indices
  lipid_signal <- slice(renamed, lip_upper:lip_lower)
  return (lipid_signal) 
}
#now that the function is loaded, we can insert our sample data and then save it as data, for example:
carbonyl_signal_1<-get_carbonyl_signal(AlgaeSample1)