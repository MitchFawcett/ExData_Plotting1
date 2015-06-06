## Generate Plot 4 for Exploratory Data Analysis Assignment 1
## By. M. Fawcett
## 06/05/2015
## Assumes source data files are in R working dirctory.
## Assumes R script "readData.R is in R working directory.

###############  Load data  ##################
## Obtained start and end line numbers of source data for Feb. 1 
## to Feb. 2 2007 by using grep in Mac Terminal window.
## First line # (Feb. 1, 2007) = 66638:  
## grep -n -m 1 ^'1/2/2007;' /Users/mitchellfawcett/Documents/RProjects/ExploratoryAnalysis/household_power_consumption.txt
## Last line # (Feb. 2, 2007) = 69517:
## grep -n ^'2/2/2007;' /Users/mitchellfawcett/Documents/RProjects/ExploratoryAnalysis/household_power_consumption.txt
## Number of rows needed to read: 69517 - 66638 + 1 = 2880

## Read in just the rows of data for Feb 1-2, 2007
df <- read.csv("household_power_consumption.txt", 
               na.strings = "?", 
               header = FALSE, 
               skip = 66637, 
               nrows = 2880, 
               sep = ";",
               colClasses = c("character", "character", rep("numeric",  7)))

## Get the column names by reading the first row of the original data file again.
colhead <- read.csv("household_power_consumption.txt", nrows = 1, sep = ";", header = TRUE)

## Add the column names to data frame.
names(df) <- names(colhead)

## Add a POSIX datetime column to data frame. 
df <- within(df, DateTime <- as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

###################  Create Plot # 4  ####################
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA) 

par(mfrow=c(2,2))

## Plot upper left
plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Plot upper right
plot(df$DateTime, df$Voltage, type = "l", xlab = "Datetime", ylab = "Voltage")

#Plot lower left
plot(df$DateTime, df$Sub_metering_1, type = "l", xlab = "", ylab = "", ylim = c(1, 38))
par(new=T)
plot(df$DateTime, df$Sub_metering_2, type = "l", xlab = "", ylab = "", ylim = c(1, 38), col = "red")
par(new=T)
plot(df$DateTime, df$Sub_metering_3, type = "l", xlab = "", ylab = "Energy Sub Metering", ylim = c(1, 38), col = "blue")
par(new=T)
legend(x = "topright", bty = "n", lty = 1:1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
par(new=F)

## Plot lower right
plot(df$DateTime, df$Global_reactive_power, type = "l", xlab = "Datetime", ylab = "Global_reactive_power")

dev.off()


