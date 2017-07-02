# Setup for part 4
# Bring in the libraries I'll need - dplyr and data.table

library(dplyr)
library(data.table)

# The data file's in the working folder. Read the data in, but only from the allowed dates 2007-02-01 and 2007-02-02.

dataFile <- "exdata_data_household_power_consumption/household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

AllowedDates <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# Convert the allowed dates into a usable format

str(AllowedDates)
globalActivePower <- as.numeric(AllowedDates$Global_active_power)
globalReactivePower <- as.numeric(AllowedDates$Global_reactive_power)
voltage <- as.numeric(AllowedDates$Voltage)
datetime <- strptime(paste(AllowedDates$Date, AllowedDates$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
subMetering1 <- as.numeric(AllowedDates$Sub_metering_1)
subMetering2 <- as.numeric(AllowedDates$Sub_metering_2)
subMetering3 <- as.numeric(AllowedDates$Sub_metering_3)

# Finally, do the plotting

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="Date/Time", ylab="Voltage")
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")

lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="Date/Time", ylab="Global_reactive_power")
dev.off()