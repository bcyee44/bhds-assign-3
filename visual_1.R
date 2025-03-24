###Visualization 1:
#Stratified boxplot of text messages by Group and Time
#Hint: Faceted Boxplot

#set working directory as folder on desktop
#setwd("C:/Users/brand/OneDrive/Desktop/BHDS2010/ASSIGN3/bhds-assign-3")
#setwd("/Users/vleary71/Desktop/BHDS2010/ASSIGN3/bhds-assign-3")
#successfully set working directory


#Read data set in
#Use read.csv since the file is a csv file
text_data <- read.csv("TextMessages.csv")
#File was successfully read in

#Use nrow() to check the number of rows/observations
nrow(text_data)
#There are 50 rows in the dataset

#Use names() to view the variable names
names(text_data)
#There are variables "Group", "Baseline", "Six_months" and "Participant"

#Load ggplot2
library(ggplot2)

#load reshape to convert data to long with melt()
library(reshape)

#Using cbind to combine the melted text data without the Group variable with a
#a column containing the Group variable replicated a second time.
long_text_data <- cbind(melt(text_data[,-1],
                             id.vars = "Participant", #not melting Participant
                             variable_name = "Time", #Variable name for melted
                       value.names = "Texts"), #argument not working? Supposed
                       #to change the variable name to "Texts", but doesn't 
                       #seem to work anymore.
                       Group = rep(text_data$Group, 2)) #Using rep() to replicate

#Use is.factor() to check if Group is a factor
is.factor(long_text_data$Group)
#FALSE was returned
#Use as.factor() to change it to a factor
long_text_data$Group <- as.factor(long_text_data$Group)
#Verify again with is.factor()
is.factor(long_text_data$Group)
#TRUE is returned this time

#Check if Time is a factor with is.factor()
is.factor(long_text_data$Time)
#TRUE was returned

#Check the factor names of Time using levels()
levels(long_text_data$Time)
#"Baseline" and "Six_months" were returned

#Use levels again and set the names of the factors to have "Six Months" for
#easier readability for the boxplots
levels(long_text_data$Time) <- c("Baseline", "Six Months")
#check the levels again
levels(long_text_data$Time)
#Now "Baseline" and "Six Months" was returned


######Plot the boxplots

#Use ggplot() with aes set for group on x to stratify and value on y with
#fill = group to allow the plots to be colored
ggplot(long_text_data, aes(x=Group, y = value, fill = Group)) + 
  #adding a boxplot with geom_boxplot()
  geom_boxplot() +
  #Use facet_wrap() to stratify the boxplots by time
  facet_wrap(.~Time) +
  #add labels for the title and y axis
  labs(title = "Boxplots of Text Data Stratified by Group and Time",
       y = "Total Text Messages")+ 
  #adding a color to the boxplots
  scale_fill_brewer(palette = "Pastel1") + 
  #centering the title of the plot
  theme(plot.title = element_text(hjust = 0.5))
#The figure was successfully created

