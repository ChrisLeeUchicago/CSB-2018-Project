#finally, we can evaluate the contets of our samples by finding the ratio of the sample AUCs to exemplar AUCs
#make sure a sample AUC (genarated by getAUC function) exists in the global environment

get_ratio <- function(sampleAUC, AUC_dex, AUC_tri){
  #separate sample carbonyl AUC from sample OH AUC
  sample_carbonyl_AUC <-sampleAUC[1]
  sample_OH_AUC <- sampleAUC[2]
  #calculate the ratio of sample to exemplar
  carbonyl_ratio <-sample_carbonyl_AUC/AUC_tri
  OH_ratio <- sample_OH_AUC/AUC_dex
  
  print(paste("The AUC ratio for carbonyl is", carbonyl_ratio)) #print the results
  print(paste("The AUC ratio for OH is", OH_ratio)) #print the results
}

#once the funtion above is loaded, run it with the data. For example:
get_ratio(sampleAUC, AUC_dex, AUC_tri)