# setwd("~/Dropbox/__ summer 2015/_Exploratory Data Analysis/project 1")

# use lubridate package for easy date/time parsing
require(lubridate)

# read full hpc data set
hpcFile <- "household_power_consumption.txt"
hpcColClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric" )
hpc <- read.table(file=hpcFile, header=T, sep=";", na.strings = "?", colClasses = hpcColClasses)

# Convert Date and Time values to POSIXct
hpc$DateTime <- dmy_hms(paste(hpc[,1], hpc[,2]))
hpc$Date <- dmy(hpc$Date)
hpc$Time <- hms(hpc$Time)

# select the data for 2/1/2007 and 2/2/2007 and place in a subset
inSelection <- (year(hpc$Date) == 2007 & month(hpc$Date) == 2 & (day(hpc$Date) %in% c(1,2)))
hpcSelection <- hpc[inSelection,]

# remove the huge hpc data file form memory
rm(hpc)
rm(inSelection)

# open a graphic device to a png file
png(filename = "plot1.png",width = 500, height = 500, units = "px", pointsize = 12, bg = "white")

# create histogram
hist(hpcSelection[,"Global_active_power"], col = "red", main="Global Active Power",
          xlab="Global Active Power (kilowatts)", ylab="Frequency")

# close the png graphics device
dev.off()