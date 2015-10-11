# plot2.R
## Assume file has been downloaded to the working directory
##
## set working directory
## setwd("enter full path")
## getwd()


## stringsAsFactors = FALSE tells R to preserve character variables as they are rather than convert to factors.
## To explain, a factor is a categorical variable whose categories represent levels. 
## These levels are named, like characters, but the levels additionally have a numerical interpretation. 
## It is easy to convert character data to factors later, when you need them.
## https://www.zoology.ubc.ca/~schluter/R/data/


df_hpc <- read.table("household_power_consumption.txt", sep = ";", quote="\"", stringsAsFactors=FALSE, header=TRUE)
## Checkout the data if curious
## View(df_hpc)  

## reformat to Day-Month-Year format. With strptime you can format to data AND time
df_hpc$Date <- strptime(df_hpc$Date, "%d/%m/%Y")

DATE1 <- strptime("2007-02-01", "%Y-%m-%d")

DATE2 <- strptime("2007-02-02", "%Y-%m-%d")

df_feb0102 <- df_hpc[df_hpc$Date >= DATE1 & df_hpc$Date <= DATE2, ]

## combine date and time into one column uing package Lubridate
## the function can be called in different permutaitons dmy_hms or ydm_hms etc.
## use ymd_hms because the date is stored in Year-Month-Day format. Otherwise it will not work.

library(lubridate)
df_feb0102$DateTime <- ymd_hms(paste(df_feb0102$Date, df_feb0102$Time))

png (filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12)

plot (df_feb0102$DateTime, df_feb$Global_active_power, type="l", xlab="Date Time", ylab="Global Active Power (kilowatts)")

dev.off()

################################################### plot2.R ##############################################
