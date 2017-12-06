### Milla Peltoniemi
### 29.11.2017
### Exercise 4

library(dplyr); library(ggplot2)

# The data sets contain data in the human development index (hd) and the gender inequality index (gii).
# http://hdr.undp.org/en/content/human-development-index-hdi

# Read the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Dimension and structure of the data
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)

# Rename long column names to shorter ones
colnames(hd)
colnames(gii)

new_colnames_hd <- c("HDI.Rank","Country","HDI","Life.Exp","Edu.Exp","Edu.Mean","GNI","GNI.Minus.Rank")
new_colanmes_gii <- c("GII.Rank", "Country", "GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")

colnames(hd) <-new_colnames_hd 
colnames(gii) <-new_colanmes_gii 

colnames(hd)
colnames(gii)

# Mutate the "Gender inequality" data
gii <- mutate(gii, Edu2.FM = (Edu2.F / Edu2.M))
gii <- mutate(gii, Labo.FM = (Labo.F / Labo.M))

colnames(gii)

#Join the two datasets hd and gii
human <- inner_join(hd, gii, by = c("Country"), suffix = c(".hd", ".gii"))
colnames(human)
dim(human)

#write.csv(human, file="human.csv", row.names= FALSE)

# Week 5 Data Wrangling
# 6.12.2017

colnames(human)

human <- mutate(human, as.numeric(GNI))
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

complete.cases(human)
human_ <- filter(human, complete.cases(human)== TRUE)

human$Country
last <- nrow(human_) - 7
human_ <- human_[1:last, ]
rownames(human_) <- human_$Country
human_ <- human_[ ,2:ncol(human_)]

dim(human_)
human <- human_

write.csv(human, file="human.csv", row.names= TRUE)
human <- read.csv("human.csv", row.names=1)
dim(human)
head(human)
