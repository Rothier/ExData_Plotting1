library(dplyr)
library(lubridate)
# reads dataset
data <- read.table("household_power_consumption.txt", header = T, sep = ";")
# converts Date column do type Date and filters the required dates
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")
# Joins Date and Time column into the latter and deleting the former, 
# then converts the result into a Datetime class column
data$Time <- paste(data$Date, data$Time)
data <- data[,-1]
data$Time <- as_datetime(data$Time, format = "%Y-%m-%d %H:%M:%S")
# Converts global active and reactive power, voltage and 
# all three submetering columns from factor to numeric
data$Global_active_power <- as.numeric(levels(data$Global_active_power)[data$Global_active_power])
data$Sub_metering_1 <- as.numeric(levels(data$Sub_metering_1)[data$Sub_metering_1])
data$Sub_metering_2 <- as.numeric(levels(data$Sub_metering_2)[data$Sub_metering_2])
data$Sub_metering_3 <- as.numeric(levels(data$Sub_metering_3)[data$Sub_metering_3])
data$Voltage <- as.numeric(levels(data$Voltage)[data$Voltage])
data$Global_reactive_power <- as.numeric(levels(data$Global_reactive_power)[data$Global_reactive_power])
# Constructs the plot and exports it as required png and changes parameters to allow four plots in 
# one visual device (png in this case)
png("plot4.png", height=480, width=480)
par(mfrow=c(2,2))
# Plot 1
plot(data$Global_active_power ~ data$Time, 
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     type="l")
# Plot 2
plot(data$Voltage ~ data$Time, 
     ylab = "Voltage",
     type="l")
# Plot 3
plot(data$Sub_metering_1 ~ data$Time, 
     ylab = "Energy sub metering",
     type="l")
lines(data$Sub_metering_2 ~ data$Time, col="red")
lines(data$Sub_metering_3 ~ data$Time, col="blue")
legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1)
# Plot 4
plot(data$Global_reactive_power ~ data$Time, 
     ylab = "Global_reactive_power",
     type="l")
dev.off()