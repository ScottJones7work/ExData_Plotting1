# Setup for part 2
# Bring in the libraries I'll need - dplyr and data.table

library(dplyr)
library(data.table)

# The data file's in the working folder. Read the data in, but only from the allowed dates 2007-02-01 and 2007-02-02.

dataFile <- "exdata_data_household_power_consumption/household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

AllowedDates <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# Convert the allowed dates into a usable format and convert to datetime

str(AllowedDates)
datetime <- strptime(paste(AllowedDates$Date, AllowedDates$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(AllowedDates$Global_active_power)

# Finally, do the plotting

png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()










