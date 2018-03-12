#this portion of the code directly follows from the get carbonyl and get OH signal functions
#it assumes that the global environment contains the carbonyl and OH signal data

#for this part, we'll need the package zoo so we'll need to install and load it
install.packages("zoo")
#if zoo is already installed, we just need to load the library
library(zoo)

get_AUC <- function(carbonyl, OH){
  #separate Wavenumber and Absorbance values of the signal data
  wave_carbonyl <-select (carbonyl, Wavenumbers)
  absorb_carbonyl <- select (carbonyl, Absorbance)
  wave_OH <-select (OH, Wavenumbers)
  absorb_OH <-select (OH, Absorbance)
  
  #we're going to use the rollmean function from the zoo library to approximate Area under the Curve (AUC)
  #it's important to note that rollmean requires vectors so we'll be using the pull function to get a vector from the tbls
  
  carbvecX <- as.numeric(pull(wave_carbonyl)) #getting vectors
  carbvecY <- as.numeric(pull(absorb_carbonyl)) #getting vectors
  carbid <- order(carbvecX) #providing indices for the rollmean function
  AUC_carbonyl <- sum(diff(carbvecX[carbid])*rollmean(carbvecY[carbid],2))    #rollmean function giving AUC
  
  OHvecX <- as.numeric(pull(wave_OH)) #getting vectors
  OHvecY <- as.numeric(pull(absorb_OH)) #getting vectors
  OHid <- order(OHvecX) #providing indices for the rollmean function
  AUC_OH <- sum(diff(OHvecX[OHid])*rollmean(OHvecY[OHid],2))   #rollmean function giving AUC
  
  areas_carb_and_OH <-c(AUC_carbonyl, AUC_OH) #concatenate the two AUC values
  
  print(paste("The AUC for carbonyl is", AUC_carbonyl)) #print the results
  print(paste("The AUC for OH is", AUC_OH)) #print the results
  
  return(areas_carb_and_OH) #return the concatenated AUC values
}

#once the function is loaded, we can run it with our carbonyl and OH signal data and save the output
#for example:
sampleAUC <-get_AUC(carbonyl_signal_1, OH_signal_1)
