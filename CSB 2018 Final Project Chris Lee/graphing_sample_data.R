#Load the tidyverse library for better organizatin of data.

library(tidyverse) 

#Load the sample data, remember to set working directory to this folder.

AlgaeSample1<-read_csv("AlgaeSample1.csv")

#check to see what the data AlgaeSample1 looks like

head(AlgaeSample1)
tail(AlgaeSample1)

#It seems like the head of the data includes instrument settings and the tail of the data ends at row 6056

#A quick look at the data shows that the actual data doesnt start until row 56.

View(AlgaeSample1)

#We want to get the data without the instrument settings so we can write a function: 

graph_sample_data <- function (sampledata) {
  #slice/isolate the data we want
  sliced <- slice(sampledata, 56:6056)
  #rename the columns
  slicedrenamed <- sliced %>% rename(Wavenumbers = 'PE IR       SPECTRUM    SPECTRUM    ASCII       PEDS        1.60', Absorbance = X2 )
  #plot the data, and add tick marks on the x axis
  thespectra <-ggplot(data= slicedrenamed, aes(x=Wavenumbers, y = Absorbance, group = 1)) + 
    geom_line() + scale_x_discrete(breaks = c(1500,2000, 2500,3000, 3500), labels = c(1500, 2000, 2500,3000, 3500))
  return(thespectra)
}

#Now that the function is created, we can load the sample data to visualize the graphs
graph_sample_data(AlgaeSample1)

#If desired, we can save the graphs using the command: ggsave(file = "insertgraphnamehere.pdf")