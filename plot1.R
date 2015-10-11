################################################### plot 1 ##############################################
## Code for plot1    plot1.R
## Assume file has been downloaded to the working directory
##
## set working directory
## setwd("full pathname")
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

## convert from character to double numeric
df_feb0102$Global_active_power <- as.numeric(df_feb0102$Global_active_power)

# plot 1
## invoke the png device driver to generate in png format
png (filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12)
## draw the plot. You will not see it on the screen because it is writing to the png device and not the screen device
hist(df_feb0102$Global_active_power, col='red', main ="Global Active Power", xlab="Global Active Power (kilowatts)"  )

## write from the png device to the file plot1.png
dev.copy(png,'plot1.png')

## close the png device, so that the file write completes.
## You will be able to view the file in your directory only after it is closed.
dev.off()

################################################### plot 1 ##############################################
