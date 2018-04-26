# load some packages
library(ggplot2)
library(dplyr)

# load the data set into R
df = read.csv("~/Downloads/Oral Fungi Survey - Sheet1.csv")

#remove all rows that are missing any data in the first 12 columns
complete = which(complete.cases(df[,1:12]) == TRUE)
dat = df[complete,]

# look at dimensions of our data frame (rows, columns)
dim(dat) # we have 196 samples left...maximum should be 188 so we need to lose 8 more somehow

# remove any rows where diet isn't "Vegetarian" or "Omnivore"
levels(dat$Diet) # look at options in the data
omniveg = which(dat$Diet %in% c("Omnivore","Vegetarian")) # find all rows where diet is omnivore or vegetarian

# subset, removing non-veg and non-omnivore
dat = dat[omniveg,]

dim(dat) # down to 191 samples....still need to remove a few

# let's do it randomly
set.seed(123)
randomrows = sample((row.names(dat)),188, replace = FALSE)

# subset data frame to the randomly selected rows
dat = dat[randomrows,]

# rearrange to correct order for ease of sample processing
dat = dat[order(dat$SampleID),]


# reclassify columns as new factors where needed
dat$Diet = as.factor(as.character(dat$Diet))
dat$ActivityLevel = as.factor(as.character(dat$ActivityLevel))
dat$Gender = as.factor(as.character(dat$Gender))
dat$Ethnicity = as.factor(as.character(dat$Ethnicity))

write.csv(dat$SampleID, file = "~/Desktop/UVU/Research/Oral_Mycobiome/samples_to_use.txt", row.names = FALSE, 
          col.names = "SampleID", quote = FALSE)
