#--Setting working directory--##
setwd("~/Dropbox/Cursos Online/Exploratory Data Analysis - Coursera/Course Project 1")

##-----------------------##
##--Preparing the data--##
##-----------------------##
# Loading the Data base
library(readr)
household_power_consumption <- read_delim("household_power_consumption.txt", 
                                          ";", escape_double = FALSE, trim_ws = TRUE)
str(household_power_consumption)
names(household_power_consumption)

# data from the dates 2007-02-01 and 2007-02-02.
class(household_power_consumption$Date)

#--Properly format for date--##
library(dplyr)
df <- household_power_consumption
head(df$Date)
date2 <- strptime(df$Date, "%d/%m/%Y")  %>% as.Date()
head(date2)
df <- df %>% 
  mutate(date2 = date2)

#--subsetting--##
df2 <- subset(df, date2 >= as.Date("2007-02-01") & 
                date2 <= as.Date("2007-02-02"))
dim(df2)

## Combine Date and Time column
dateTime <- paste(df2$date2, df2$Time)

df2$date_time <- as.POSIXct(dateTime)
##----------------------------------------------------------------------------##

##--Creating and saving the plot--##
png("plot2.png", width = 480, height = 480, units = "px")
plot(df2$Global_active_power ~ df2$date_time, type = "l",
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")
dev.off()