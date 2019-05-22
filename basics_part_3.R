# Data Structure - review
x<-1

x<-1:10 # Vector

x<-matrix(0,nrow=2,ncol=2) # Matrix

var1<-c(1,2,3)
var2<-c("a","c","c")
x<-data.frame(var1, var2) # Data Frame

# Data Structure - lists
l <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.5, 4.2))
l1<-list(var1=1:3, var2="a", var3=c(TRUE, FALSE, TRUE), var4=c(2.5, 4.2))

# Control Structures
# if statement
if (test_expression) {
  statement
}

x<-1
y<-1

if (x==y) {
  print("Yes")
}

x<-1:10
y<-1:10

if (x==y) {
  print("Yes")
}

x<-1:10
y<-2:11

if (x==y) {
  print("Yes")
}

x<-"a"
y<-"a"

if (x==y) {
  print("Yes")
}

var<-c(10,20,30)

if (any(var>10)) {
  print("Yes")
}

if (TRUE) {
  print("Yes")
}

# if else
if (test_expression) {
  print("statement 1")
} else {
  print("statement 2")
}

if (TRUE) {
  print("Yes")
}else {
  print("No")
}

ifelse(any(var>10),"There are values greater than 10","There are no values greater than 10")

ifelse(any(var<10),"There are values greater than 10","There are no values less than 10")

x <- 6
if(x >= 10){
  print("x is greater than 10")
} else if(x >= 5 & x < 10){
  print("x is between 5 and 10")
} 


# for loop
for (i in 1:10){
  print(i)
}

names<-letters[1:10]

for (i in names){
  print(i)
}

# while loop

index<-1

while(index <= 10) {
  print(index)
  index<-index+1
}

# when to use while and when to use for loop?
counter <- 1
x <- 5
set.seed(3)

while(x >= 3 & x <= 8 ) {
  coin <- rbinom(1, 1, 0.5)
  
  if(coin == 1) { ## random walk
    x <- x + 1
  } else {
    x <- x - 1
  }
  cat("On iteration", counter, ", x =", x, '\n')
  counter <- counter + 1
}

# use of break 
x <- 1:5
for (i in x) {
  if (i == 3){
    break
  }
  print(i)
}

# Importance of vector operations

x<-1:1000
start_time <- Sys.time()
for (i in 1:length(x)){
  x[i]<-x[i]*2
}
end_time <- Sys.time()

start_time1 <- Sys.time()
x<-x*2
end_time1 <- Sys.time()

print(paste0("Time taken using for loop: ", (end_time-start_time)))
print(paste0("Time taken using vector: ", (end_time1-start_time1)))

# Data Wrangling
# Read a dataframe
# Explore data
head(crime)

# Select or replace variable values
# Numerical variables
t<-crime$REPORTING_AREA[1:10]
t<-crime$REPORTING_AREA[crime$REPORTING_AREA>300]

# String variables
t<-crime$OFFENSE_CODE_GROUP[crime$OFFENSE_CODE_GROUP=="Medical Assistance"]

# Generatig subset dataframe
t<-crime[1:10,1:10]

# Query
t<-is.na(crime$DISTRICT)
t<-any(crime$OFFENSE_CODE_GROUP=="Medical Assistance")
t<-which(crime$OFFENSE_CODE_GROUP=="Medical Assistance")
t<-unique(crime$OFFENSE_CODE_GROUP)

# sort, order
crime <- crime[order(crime$OFFENSE_CODE_GROUP),]
crime <- crime[order(crime$OFFENSE_CODE_GROUP, crime$DISTRICT),]
crime <- crime[order( crime$DISTRICT, decreasing = TRUE),]

crime <- crime[order(crime$DISTRICT),]
crime <- crime[order(crime$DISTRICT,-crime$REPORTING_AREA),]


# Subset dataframe (chosing rows on column condition)
ind<-which(crime$OFFENSE_CODE_GROUP=="Medical Assistance" )
new_df<-crime[ind,]

ind<-which(crime$OFFENSE_CODE_GROUP=="Medical Assistance" & crime$REPORTING_AREA==912)
new_df<-crime[ind,]

new_df1<-subset(crime, crime$OFFENSE_CODE_GROUP=="Medical Assistance" & crime$REPORTING_AREA==912)

new_df1<-subset(crime, crime$OFFENSE_CODE_GROUP=="Medical Assistance" | crime$OFFENSE_CODE_GROUP=="Investigate Person")


# Use of libraries for data wrangling
library(stringr)
# Detect
t<-str_which(crime$OFFENSE_CODE_GROUP, "Medical Assistance")
t<-str_detect(crime$OFFENSE_CODE_GROUP, "Medical Assistance")
t<-str_count(crime$OFFENSE_CODE_GROUP, "Medical Assistance")
t<-str_locate(crime$OFFENSE_CODE_GROUP, "Medical")

# Subset strings
str_sub("Northeastern University",1,3)
t<-str_sub(crime$OFFENSE_CODE_GROUP,1,3)
t<-str_subset(crime$OFFENSE_CODE_GROUP,"Medical")
t<-str_extract(crime$OFFENSE_CODE_GROUP,"Drug")
t<-str_match(crime$OFFENSE_CODE_GROUP,"Drug")

# Length of strings
t<-str_length(crime$OFFENSE_CODE_GROUP)

# Replace
str_replace("Northeastern University","Northeastern","Harvard")
str_to_lower("Northeastern University")
str_to_upper("Northeastern University")
str_to_title("northeastern university")

t<-str_replace(crime$OFFENSE_CODE_GROUP,"Medical","med")
t<-str_to_lower(crime$OFFENSE_CODE_GROUP)

# Join strings
str_c("Northeastern","University")
str_c("Northeastern"," ","University")

t<-str_c(crime$DISTRICT,crime$REPORTING_AREA)

# Split strings
str_split("northeastern university boston"," ",3)

# Sort
t<-str_sort(crime$OFFENSE_DESCRIPTION)
t[1:10]
t1<-str_sort(crime$REPORTING_AREA)
t1[1:10]

# dplyr package

library(dplyr)
# Manipulate (subsetting) cases--------------

df1<-filter(nydata,BOROUGH=="MANHATTAN")
# Alternative: df1<-subset(nydata,BOROUGH=="MANHATTAN")

# Try filtering using loop
start_time <- Sys.time()
df1<-filter(nydata,BOROUGH=="MANHATTAN")
end_time <- Sys.time()

start_time1 <- Sys.time()
ind=0
k=1
for(i in 1:length(nydata$BOROUGH)){
  if (nydata$BOROUGH[i]=="MANHATTAN"){
    ind[k]=i
    k=k+1
  }
}
df2<-nydata[ind,]
end_time1 <- Sys.time()

print(paste0("Time taken using filter function: ", (end_time-start_time)))
print(paste0("Time taken using loop: ", (end_time1-start_time1)))



df1<-distinct(nydata,BOROUGH)
#Alternative: unique(nydata$BOROUGH)

df1<-sample_frac(nydata, 0.1, replace = TRUE)
df1<-sample_n(nydata, 1000, replace = TRUE)

# Alternative: x<-sample(1:(length(nydata$BOROUGH)/10), replace = TRUE)
# df1<-nydata[x,]

df1<-slice(nydata,10:15)
# Alternative: df1<-nydata[10:15,]

# Manipulate variables----------------

v<-pull(nydata, BOROUGH)
v<-pull(nydata, 3)
# Alternative: v<-nydata$BOROUGH

v<-select(nydata, BOROUGH,ZIP.CODE)
# Alternative: v<-nydata[,3:4]

df1<-arrange(nydata, BOROUGH)
df1<-arrange(nydata, desc(BOROUGH))
# Alternative: df1<-nydata[order(BOROUGH),]

# Create variables----------------
df1<-mutate(nydata,newcol =2)
# Alternative: df1$newcol=2

v<-transmute(nydata, NUMBER.OF.PERSONS.INJURED)
# Alternative: v<-nydata$NUMBER.OF.PERSONS.INJURED

# Data Aggregation------------------
# One function, one variable
summarise(mtcars, mean_mpg=mean(mpg))
# One function multiple variables
summarise(mtcars, mean_mpg=mean(mpg), mean_cyl=mean(cyl))
# Many function, one variable
summarise(mtcars, mean_mpg=mean(mpg),max_mpg=max(mpg))
# Many function, multiple variable
summarise(mtcars, mean_mpg=mean(mpg),max_cyl=max(cyl))

# One function, one variable using group_by function
summarise(group_by(mtcars,cyl), mean_mpg=mean(mpg))
# One function, many variable using group_by function
summarise(group_by(mtcars,cyl), mean_mpg=mean(mpg), mean_disp=mean(disp))
# Many function, many variable using group_by function
summarise(group_by(mtcars,cyl), count_cyl=n(), mean_mpg=mean(mpg), max_disp=max(disp))

# Use of summarise_each function
summarise_each(group_by(mtcars,cyl),funs(min, max, mean),mpg,disp)

# Calculate the number of persons injured by borough using summarise


# Merging dataframes--------------------------
one <- mtcars[1:4, ]
two <- mtcars[11:14, ]
df3<-bind_rows(one, two)
# Alternative: df3<-rbind(one,two)
df3<-bind_cols(one, two)
# Alternative: df3<-cbind(one,two)

# inner_join(x, y): Return all rows from x where there are matching values in y, 
#and all columns from x and y. If there are multiple matches between x and y, 
#all combination of the matches are returned. 
# This is a mutating join.
ljsp <- left_join(superheroes, publishers)


# inner_join(x, y): Return all rows from x where there are matching values in y, 
# and all columns from x and y. If there are multiple matches between x and y, 
# all combination of the matches are returned. 
# This is a mutating join.
ijps <- inner_join(publishers, superheroes)

# semi_join(x, y): Return all rows from x where there 
# are matching values in y, keeping just columns from x.
# A semi join differs from an inner join because an inner join will return 
# one row of x for each matching row of y, where a semi join will never duplicate rows of x. 
# This is a filtering join.
sjsp <- semi_join(superheroes, publishers)

# anti_join(x, y): Return all rows from x where there are not matching values in y, 
#keeping just columns from x. This is a filtering join.
ajps <- anti_join(publishers, superheroes)

# full_join(x, y): Return all rows and all columns from both x and y. 
#Where there are not matching values, returns NA for the one missing. 
#This is a mutating join.
fjsp <- full_join(superheroes, publishers)


# Pipe operator for claen code
library(magrittr)

nydata %>%
  group_by(BOROUGH)%>%
  summarise(sum_injured=sum(NUMBER.OF.PERSONS.INJURED, na.rm=TRUE)) %>%
  arrange(desc(sum_injured))

test<-nydata %>%
  filter(BOROUGH=="MANHATTAN")%>%
  select(BOROUGH, DATE, TIME)

nydata %>%
group_by(BOROUGH) %>%
  summarize(total = sum(NUMBER.OF.PERSONS.INJURED))

nydata %>%
  group_by(BOROUGH) %>%
  summarize(total = sum(NUMBER.OF.PERSONS.INJURED,na.rm=TRUE))
  
nydata %>%
  group_by(BOROUGH) %>%
  summarize(total_injured = sum(NUMBER.OF.PERSONS.INJURED,na.rm=TRUE), motorist_killed=sum(NUMBER.OF.MOTORIST.KILLED,na.rm=TRUE))

nydata %>%
  group_by(BOROUGH,NUMBER.OF.MOTORIST.KILLED) %>%
  summarize(total_injured = sum(NUMBER.OF.PERSONS.INJURED,na.rm=TRUE))

 
  