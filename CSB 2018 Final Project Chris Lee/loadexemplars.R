#remember to set directory to project file
#remember to have tidyverse loaded for organization of data
library(tidyverse) 

#Now that we have AUC values for carbonyl and OH peaks, we need to give meaning to them by providing context using exemplars
#As mentioned above, the exemplar for lipid/carbonyl will be tricaprin while the exemplar for carbohydrates will be dextrose.

tidyexemplars<-read_csv("exemplars in csv.csv") #load exemplar data for lipid (tricaprin), and carbohydrate (dextrose)
head(tidyexemplars) #check to see if upload worked

#separate the exemplar data from each other and check to see if separation worked
trisig <- select(tidyexemplars, Tri, TriSig)
head(trisig)
dexsig <- select(tidyexemplars, Dex, DexSig)
head(dexsig)

#now that we have this data, we can graph it to see what the exemplars look like on FTIR
#plot the data, and add tick marks on the x axis
#tricaprin plot
ggplot(data= trisig, aes(x=Tri, y = TriSig, group = 1)) + geom_line() 
#dextrose plot
ggplot(data= dexsig, aes(x=Dex, y = DexSig, group = 1)) + geom_line() 

#We can check to see that, indeed, the Dextrose exemplar has a large,broad peak around wavenumber 3300
#and the Tricaprin exemplar does indeed have a narrow but very high peak around wavenumber 1700

#after we've confirmed that the exemplars are in order, we extract the carbonyl signal of the tricaprin 
#and the OH signal of the dextrose in a similar way as we did for our sample(s)

tri_upper <-which (trisig ==1750)
tri_lower <-which (trisig ==1650)
tri_signal <- slice(trisig, tri_upper:tri_lower)

dex_upper <-which (dexsig ==3400)
dex_lower <-which (dexsig ==3200)
dex_signal <- slice(dexsig, dex_upper:dex_lower)

#finally, we calculate the AUC of the exemplars

wave_tri <-select (tri_signal, Tri)
absorb_tri <- select (tri_signal, TriSig)
wave_dex <-select (dex_signal, Dex)
absorb_dex <-select (dex_signal, DexSig)

#we're going to use the rollmean function again to calculate AUC so make sure the zoo library is loaded
#and, once again, we're using the pull function to get a vector from the tbls

trivecX <- as.numeric(pull(wave_tri)) #getting vectors
trivecY <- as.numeric(pull(absorb_tri)) #getting vectors
tri_id <- order(trivecX) #providing indices for the rollmean function
AUC_tri <- sum(diff(trivecX[tri_id])*rollmean(trivecY[tri_id],2))    #rollmean function giving AUC

dexvecX <- as.numeric(pull(wave_dex)) #getting vectors
dexvecY <- as.numeric(pull(absorb_dex)) #getting vectors
dex_id <- order(dexvecX) #providing indices for the rollmean function
AUC_dex <- sum(diff(dexvecX[dex_id])*rollmean(dexvecY[dex_id],2))   #rollmean function giving AUC

#view the AUC values
AUC_dex
AUC_tri