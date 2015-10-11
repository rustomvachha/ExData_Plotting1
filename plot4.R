################################################### plot4.R ##############################################
#plot 4
## Assume file has been downloaded to the working directory
##
## set working directory
## setwd("full directory path")
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



png (filename = "plot4.png", width = 582, height = 418, units = "px", pointsize = 12)
par(mfrow = c(2,2))  ## make sure this setting is done after the png function is called. not before. otherwise only one plot will get saved.

plot (df_feb0102$DateTime, df_feb0102$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot (df_feb0102$DateTime, df_feb0102$Voltage, type="l", xlab="Date Time", ylab="Voltage")

plot(df_feb0102$DateTime, df_feb0102$Sub_metering_1, type="n", xlab = "", ylab="Energy sub metering")

points (df_feb0102$DateTime, df_feb0102$Sub_metering_1, type="l", xlab="")
points (df_feb0102$DateTime, df_feb0102$Sub_metering_2, type="l", xlab="", ylab="Energy sub metering", col="red")
points (df_feb0102$DateTime, df_feb0102$Sub_metering_3, type="l", xlab="", ylab="Energy sub metering", col="blue")
legend( x="topright", 
        legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
        col=c("black","red","blue"), y.intersp = 0.3, lwd=2, cex = 0.6, merge=FALSE, trace=TRUE)

plot (df_feb0102$DateTime, df_feb0102$Global_reactive_power, type="l", xlab="Date Time", ylab="Global_reactive_power")
dev.off()
################################################### plot4.R ##############################################
