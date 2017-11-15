### Milla Peltoniemi
### 15.11.2017
### Exercise 2

## Data wrangling

# read csv data
lrn14 <- read.csv('data/JYTOPKYS3-data.txt',sep='\t')

#dimensions
dim(lrn14)

#structures
str(lrn14)

#gender
lrn14$gender <- lrn14$gender

#age
lrn14$age <- lrn14$Age

#attitude 
lrn14$attitude <- lrn14$Attitude / 10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- lrn14[deep_questions]
# Deep/12 (min = 1, max = 5)
lrn14$deep <- rowMeans(deep_columns)/12

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- lrn14[surface_questions]
# Surface/12 (min = 1, max = 5)
lrn14$surf <- rowMeans(surface_columns)/12

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- lrn14[strategic_questions]
# Strategic/8 (min = 1, max = 5)
lrn14$stra <- rowMeans(strategic_columns)/8

lrn14$points <-  lrn14$Points

#gender, age, attitude, deep, stra, surf and points 
lrn14 <- lrn14[c("gender", "age", "attitude","deep", "stra", "surf","points")]

# filter zero data points away
lrn14 <- lrn14[lrn14$points > 0,]

#dim is 166, 7
dim(lrn14)
head(lrn14)

write.csv(lrn14, 'data/learning2014.csv', row.names=F)
testRead <- read.csv('data/learning2014.csv')
head(testRead)


## Analysis

library(ggplot2)
library(GGally)

# A study from a cource "Johdatus yhteiskuntatilastotieteeseen, syksy 2014" about learning and teaching statistics
# Age      Age (in years) derived from the date of birth
# Gender   Male = 1  Female = 2
# Attitude is the global attitude toward statistics
# Deep is an combination of feelings with statisics
# Stra is an combination of learning strategics
# Surf is an combination of which things to concentrate on studies

# read csv/txt data
lrn14 <- read.csv('data/learning2014.txt',sep=',')
head(lrn14)
dim(lrn14)


