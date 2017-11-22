### Milla Peltoniemi
### 22.11.2017
### Exercise 3

#UCI Machine Learning Repository, Student Performance Data Set
#Data contains students performance in mathematics and portuguese, including alcohol consumption
#https://archive.ics.uci.edu/ml/datasets/Student+Performance

#libraries
library(tidyr); library(dplyr); library(ggplot2)

#Read the data
math <- read.csv('Github/IODS-project/data/student-mat.csv',sep=';', header=TRUE)
por <- read.csv('Github/IODS-project/data/student-por.csv',sep=';', header=TRUE)

#Explore data structure adn dimension
glimpse(math)
glimpse(por)
dim(math)
dim(por)

#Inner join the two data sets math and por 
join_by_colnames <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
math_por <- inner_join(math, por, by = join_by_colnames, suffix=c(".math",".por"))

#Explore joined data structure and dimension
glimpse(math_por)
dim(math_por)

#Remove not joined columns
alc <- select(math_por, one_of(join_by_colnames))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by_colnames]

#Combine duplicates answers
for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- first_column
  }
}

#Glimpse at the new combined data
glimpse(alc)

#Average of the answers related to weekday(Dalc) and weekend alcohol(Walc) consumption 
#values from 1(very low) to 5(very high) 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#New column with TRUE/FALsE values for high alcohol use
alc <- mutate(alc, high_use = alc_use > 2)

#Glimpse at the mutated data
glimpse(alc)
dim(alc)

#Save the modified data
write.csv(alc, 'Github/IODS-project/data/students_alc2014.csv', row.names=F)


